require 'basis-band/version'
require 'basis-band/api-fetch'
require 'basis-band/api-auth'
require 'basis-band/api-response-model'

class BasisBand
  @cache_dir = nil

  def initialize(userid)
    @userid = userid
  end

  def set_cache_dir(dir)
    @cache_dir = dir
  end

  def data_for_day(date)
    r = cached_value_for_day(date)
    if !r
      r = fetch_value_for_day(date)
    end
    r
  end

  def cache_filename(date)
    File.join(@cache_dir, date + ".json")
  end

  def cached_value_for_day(date)
    raw = nil
    begin
      File.open(cache_filename(date), "r") { |f|
        raw = f.read
      }
    rescue
      # ignore exception
    end
    raw
  end

  def fetch_value_for_day(date)
    f = ApiFetch.new()
    raw = f.get_day(@userid, date)
    if raw && @cache_dir
      File.open(cache_filename(date), "w") { |f|
        f.write(raw)
      }
    end
    raw
  end
end
