module MonitoringService
  module XMLRPC
    class Handler
      def memory
        { memory: Memory.new.collect.total }
      end
    end
  end
end
