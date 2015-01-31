module MonitoringService
  #HACK IT IS A BIG HACK
  class Memory
    attr_accessor :total
    attr_accessor :free
    attr_accessor :available

    def collect
      self.total = get('MemTotal')
      self.free = get('MemFree')
      self.available = get('MemAvailable')
      self
    end

    def get(key)
      result = output.scan Regexp.new("#{key}\\:.* (\\d+)\\s")
      #HACK
      result[0][0].to_i
    end

    private

    def output
      @output ||= `cat /proc/meminfo`
    end

  end
end
