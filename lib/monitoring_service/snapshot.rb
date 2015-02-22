require 'json'

module MonitoringService
  class Snapshot
    attr_accessor :memory, :processor

    def collect
      self.memory = Memory.new.collect
      self.processor = Processor.new.collect
      self
    end

    def to_json
      {
        snapshot: {
          memory: {
            total: memory.total,
            free: memory.free,
            available: memory.available
          },
          cpu: {
            model: processor.model,
            cores_count: processor.cores_count,
            max_frequency: processor.max_frequency,
            min_frequency: processor.min_frequency,
            frequency: processor.frequency,
          }
        }
      }
    end
  end
end
