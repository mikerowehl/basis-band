require 'basis-band/api-fetch'
require 'basis-band/api-auth'
require 'basis-band/api-response-model'

class BasisBand
  def initialize(userid)
    @userid = userid
  end

  def data_for_day(date)
    f = ApiFetch.new()
    f.get_day(@userid, date)
  end
end
