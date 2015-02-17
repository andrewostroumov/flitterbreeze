module MonitoringService
  class SysInfo
    attr_accessor :memory
  end
  class XmlrpcHandler
    def memory
      { memory: Memory.new.collect.total }
    end
  end
end
