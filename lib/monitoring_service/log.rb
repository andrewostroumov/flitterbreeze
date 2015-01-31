require 'json'

module MonitoringService
  class Log

    attr_accessor :memory

    def collect
      self.memory = Memory.new.collect
      self
    end

    def to_json
      {
        log: {
          memory: {
            total: memory.total ,
            free: memory.free,
            available: memory.available
          }
        }
      }
    end
  end
end
