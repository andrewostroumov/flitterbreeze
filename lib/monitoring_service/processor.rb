module MonitoringService
  module Processor
    attr_accessor :model
    attr_accessor :number_of_cores
    attr_accessor :cpu_frequency

    def collect
      self.model = get('Model name')
      self.model = get('CPU\(s\)')
      self.model = get('CPU max MHz')
    end

    def get(key)
      result = output.scan Regexp.new("#{key}\\:.* (\\d+)\\s")
      result[0][0].to_i
    end

    private

    def output
      @output ||= `lscpu`
    end
  end
end
