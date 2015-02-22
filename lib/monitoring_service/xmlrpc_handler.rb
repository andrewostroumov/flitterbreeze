module MonitoringService
  class SysInfo
    attr_accessor :memory
  end
  
  class XMLRPCHandler
    def memory
      { memory: Memory.new.collect.total }
    end
  end
end
