require 'xmlrpc/server'

module MonitoringService
  class XmlrpcServer
    attr_accessor :port
    attr_accessor :instance

    def initialize
      @port ||= '1234'
    end

    def instance
      @instance ||= XMLRPC::Server.new(port)
    end

    def self.run
      server = self.new
      server.instance.add_handler("system", XmlrpcHandler.new)
      server.instance.serve
    end
  end
end
