require 'test/unit'
require 'basis-band'

class ApiResponseModelTest < Test::Unit::TestCase
  def test_defaults_url
    test_fn = File.expand_path('../2013-10-01.json', __FILE__)
    raw = File.read(test_fn)
    m = ApiResponseModel.new(raw)
    puts m.heartrate_samples
  end
end

