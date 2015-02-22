module MonitoringService
  module XMLRPC
    class Handler
      def activate(server_token)
        Config.instance.update 'server_token' => server_token
        Thread.new do
          ApiClient.new.send_server_general
        end
        { status: :activated }
      end

      def memory
        { memory: Memory.new.collect.total }
      end
    end
  end
end
