module MonitoringService
  class Memory
    def collect
      @total = get 'MemTotal'
      @free = get 'MemFree'
      @available = get 'MemAvailable'
      self
    end

    def get(key)
      result = output.scan Regexp.new("#{key}\\:.* (\\d+)\\s")
      #HACK
      result[0][0].to_i
    end

    def to_h
      {
        total: @total,
        free: @free,
        available: @available
      }
    end

    private

    def output
      @output ||= `cat /proc/meminfo`
    end
  end
end
