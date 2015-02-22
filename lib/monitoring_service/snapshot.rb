require 'json'

module MonitoringService
  class Snapshot
    attr_accessor :memory, :processor

    def collect
      self.memory = Memory.new.collect
      self.processor = Processor.new.collect
      self
    end

    def to_h
      {
        snapshot: {
          memory: memory.to_h,
          cpu: processor.to_h
        }
      }
    end
  end
end
