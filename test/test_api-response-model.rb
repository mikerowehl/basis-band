require 'test/unit'
require 'basis-band'

class ApiResponseModelTest < Test::Unit::TestCase
  def setup
    test_fn = File.expand_path('../2013-10-01.json', __FILE__)
    raw = File.read(test_fn)
    @m = ApiResponseModel.new(raw)
  end

  def test_parse_samples
    minutes = @m.samples_by_minute
    assert minutes.length == 1440
    min_first = minutes.first
    assert min_first["air_temp"] == 80.6
    min_last = minutes.last
    assert min_last["air_temp"] == 81.5
  end

  def test_state_for_time_begin
    assert @m.state_for_time(1380607140) == "inactive"
  end

  def test_state_for_time_end_overlap
    assert @m.state_for_time(1380648120) == "light_activity"
  end

  def test_state_for_time_middle
    assert @m.state_for_time(1380657480) == "moderate_activity"
  end

  def test_state_for_time_unknown
    assert @m.state_for_time(1390697860) == "unknown"
  end
end

