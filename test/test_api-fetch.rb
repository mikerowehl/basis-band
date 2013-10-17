require 'test/unit'
require 'basis-band'

class ApiFetchTest < Test::Unit::TestCase
  def setup
    @f = ApiFetch.new()
  end

  def test_defaults_url
    url = @f.get_day('123user456', '1999-12-30')
    assert url.include?('start_date=1999-12-30')
    assert url.include?('summary=true')
    assert url.include?('bodystates=true')
  end

  def test_filter_url
    url = @f.get_day('123user456', '1999-12-30', true, false)
    assert url.include?('summary=true')
    assert url.include?('bodystates=false')
  end

  def test_metrics_url
    url = @f.get_day('123user456', '1999-12-30', true, false, [:skin_temp, :steps])
    assert url.include?('heartrate=true')
    assert url.include?('steps=false')
    assert url.include?('calories=true')
    assert url.include?('gsr=true')
    assert url.include?('skin_temp=false')
    assert url.include?('air_temp=true')
  end
end

