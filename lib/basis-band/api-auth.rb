require 'uri'
require 'net/https'
require 'json'

class ApiAuth
  attr_accessor :userid

  def login(username, password)
    token = auth_request(username, password)
    get_user_id(token)
  end

  def auth_request(username, password)
    u = URI.parse('https://app.mybasis.com/login')
    http = Net::HTTP.new(u.host, u.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Post.new(u.request_uri)
    request.set_form_data({'next' => 'https://app.mybasis.com',
                          'submit' => 'Login',
                          'username' => username,
                          'password' => password})
    response = http.request(request)
    tok_match = response['set-cookie'].match /access_token=([0-9a-f]+);/
    tok_match[1]
  end

  def get_user_id(access_token)
    u = URI.parse('https://app.mybasis.com/api/v1/user/me.json')
    http = Net::HTTP.new(u.host, u.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(u.request_uri)
    request.add_field('X-Basis-Authorization', "OAuth %s" % access_token)
    json = JSON.parse(http.request(request).body)
    @userid = json['id']
  end
end
