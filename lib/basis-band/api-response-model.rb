require 'time'
require 'json'

class ApiResponseModel
  def initialize(raw_text)
    @json = JSON.parse(raw_text)
    # Use the local timezone intentionally
    @starttime = Time.at(@json['starttime'])
  end

  def state_for_time(t)
    matches = @json["bodystates"].select { |s|
      t >= s[0] && t < s[1]
    }
    if matches.length == 1
      matches[0][2]
    else
      "unknown"
    end
  end

  def hash_for_minute(min)
    t = @starttime + (min * 60)
    res = {'t' => t.strftime("%Y/%m/%d %H:%M:%S"), 'state' => state_for_time(t.to_i)}
    for m in @json["metrics"].keys
      res[m] = @json["metrics"][m]["values"][min]
    end
    res
  end

  def num_samples
    m = @json["metrics"].keys.first
    @json["metrics"][m]["values"].length
  end

  def samples_by_minute
    (0...num_samples).map { |x|
      hash_for_minute(x)
    }
  end

  def metric_summary(metric)
    {"avg" => @json["metrics"][metric]["avg"]}
  end

  def summary
    res = {}
    for m in @json["metrics"].keys
      res[m] = metric_summary(m)
    end
    res
  end
end
