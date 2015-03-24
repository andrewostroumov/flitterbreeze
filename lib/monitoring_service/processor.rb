module MonitoringService
  class Processor
    def collect
      @model = get 'Model name', convert: :to_s
      @cores_count = get 'CPU\(s\)'
      @max_frequency = get 'CPU max MHz'
      @min_frequency = get 'CPU min MHz'
      @frequency = get 'CPU MHz'
      self
    end

    def get(key, convert: :to_i)
      result = output.scan /#{key}:\s* (.+)\s/
      convert ? result[0][0].send(convert) : result[0][0]
    end
    
    def to_h
      {
        model: @model,
        cores_count: @cores_count,
        max_frequency: @max_frequency,
        min_frequency: @min_frequency,
        frequency: @frequency,
      }
    end

    private

    def output
      @output ||= `lscpu`
    end
  end
end
