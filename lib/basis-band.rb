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

  def metrics_for_day(date)
    with_cache(metrics_cache_filename(date)) { |filename|
      fetch_metrics_value(date, filename)
    }
  end

  def activities_for_day(token, date)
    with_cache(activities_cache_filename(date)) { |filename|
      fetch_activities_value(token, date, filename)
    }
  end

  def metrics_cache_filename(date)
    File.join(@cache_dir, date + "_metrics.json")
  end

  def activities_cache_filename(date)
    File.join(@cache_dir, date + "_activities.json")
  end

  def metrics_cache_files()
    Dir[File.join(@cache_dir, "*_metrics.json")]
  end

  def activities_cache_files()
    Dir[File.join(@cache_dir, "*_activities.json")]
  end

  def metrics_for_all
    metrics = metrics_cache_files.collect { |f|
      date = File.basename(f, "_metrics.json")
      [d, cached_value(f)]
    }
    Hash[metrics]
  end

  def activities_for_all
    activities = activities_cache_files.collect { |f|
      date = File.basename(f, "_activities.json")
      [d, cached_value(f)]
    }
    Hash[activities]
  end

  def with_cache(filename)
    cached_value(filename) || yield(filename)
  end

  def cached_value(filename)
    raw = nil
    begin
      File.open(filename, "r") { |f|
        raw = f.read
      }
    rescue
      # ignore exception
    end
    raw
  end

  def fetch_result_w_cache(filename)
    f = ApiFetch.new()
    r = yield f
    if r
      File.open(filename, "w") { |f|
        f.write(r)
      }
    end
    r
  end

  def fetch_metrics_value(date, filename)
    fetch_result_w_cache(filename) { |fetch|
      fetch.get_day_metrics(@userid, date)
    }
  end

  def fetch_activities_value(token, date, filename)
    fetch_result_w_cache(filename) { |fetch|
      fetch.get_day_activities(token, date)
    }
  end

end
