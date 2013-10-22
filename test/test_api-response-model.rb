require 'test/unit'
require 'basis-band'

class ApiResponseModelTest < Test::Unit::TestCase
  def test_defaults_url
    test_fn = File.expand_path('../2013-10-01.json', __FILE__)
    raw = File.read(test_fn)
    m = ApiResponseModel.new(raw)
    minutes = m.samples_by_minute
    assert minutes.length == 1440
    min_first = minutes.first
    assert min_first["air_temp"] == 80.6
    min_last = minutes.last
    assert min_last["air_temp"] == 81.5
  end
end

