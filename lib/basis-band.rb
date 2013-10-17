require 'basis-band/api-fetch'

class BasisBand
  def initialize(userid)
    @userid = userid
  end

  def data_for_day(date)
    f = ApiFetch.new()
    f.get_day(@userid, date)
  end
end
