module MonitoringService
  class Processor
    attr_accessor :model
    attr_accessor :cores_count
    attr_accessor :frequency
    attr_accessor :max_frequency
    attr_accessor :min_frequency

    def collect
      self.model = get 'Model name', convert: false
      self.cores_count = get 'CPU\(s\)'
      self.max_frequency = get 'CPU max MHz'
      self.min_frequency = get 'CPU min MHz'
      self.frequency = get 'CPU MHz'
      self
    end

    def get(key, convert: :to_i)
      result = output.scan /#{key}:\s* (.+)\s/
      convert ? result[0][0].send(convert) : result[0][0]
    end

    private

    def output
      @output ||= `lscpu`
    end
  end
end
