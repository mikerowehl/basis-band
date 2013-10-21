require 'json'

class ApiResponseModel
  def initialize(raw_text)
    @json = JSON.parse(raw_text)
  end

  def heartrate_samples
    @json["metrics"]["heartrate"]["values"].length
  end
end
