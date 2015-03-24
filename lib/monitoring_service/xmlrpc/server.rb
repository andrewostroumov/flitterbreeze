require 'xmlrpc/server'

module MonitoringService
  module XMLRPC
    class Server
      attr_accessor :port
      attr_accessor :server

      def initialize
        @port = MonitoringService.config.settings['xmlrpc_port']
        @server = ::XMLRPC::Server.new(@port, '0.0.0.0')
      end

      def self.run
        service = new
        service.server.add_handler("system", XMLRPC::Handler.new)
        service.server.serve
      end
    end
  end
end
