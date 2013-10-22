require 'time'
require 'json'

class ApiResponseModel
  def initialize(raw_text)
    @json = JSON.parse(raw_text)
    # Use the local timezone intentionally
    @starttime = Time.at(@json['starttime'])
  end

  def hash_for_minute(min)
    t = @starttime + (min * 60)
    res = {'t' => t.strftime("%Y/%m/%d %H:%M:%S")}
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
end
