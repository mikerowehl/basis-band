require 'uri'
require 'net/https'

class ApiFetch
  @@metrics = [:heartrate, :steps, :calories, :gsr, :skin_temp, :air_temp]

  def flag_value(name, bool)
    if bool
      "#{name}=true"
    else
      "#{name}=false"
    end
  end

  def filter_params(date, summary, body_states)
    p = ['interval=60', 'units=s', "start_date=#{date}", 'start_offset=0', 'end_offset=0']
    p << flag_value('summary', summary)
    p << flag_value('bodystates', body_states)
    p.join('&')
  end

  def metric_params(skip)
    @@metrics.collect { |m|
      flag_value(m.id2name, !skip.include?(m))
    }.join("&")
  end

  def url(userid, date, summary, body_states, skip_metrics)
    f = filter_params(date, summary, body_states)
    m = metric_params(skip_metrics)
    "https://app.mybasis.com/api/v1/chart/#{userid}.json?#{f}&#{m}"
  end

  def activities_url(date)
    "https://app.mybasis.com/api/v2/users/me/days/#{date}/activities?expand=activities&type=run,walk,bike"
  end

  def https_fetch(url)
    u = URI.parse(url)
    http = Net::HTTP.new(u.host, u.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(u.request_uri)
    http.request(request).body
  end

  def https_fetch_v2(url, token)
    u = URI.parse(url)
    http = Net::HTTP.new(u.host, u.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(u.request_uri)
    request.add_field('Cookie', "access_token=#{token}; scope=login")
    http.request(request).body
  end

  def get_day_metrics(userid, date, summary = true, body_states = true, skip_metrics = [])
    res = https_fetch(url(userid, date, summary, body_states, skip_metrics))
    res
  end

  def get_day_activities(token, date)
    res = https_fetch_v2(activities_url(date), token)
    res
  end
end
