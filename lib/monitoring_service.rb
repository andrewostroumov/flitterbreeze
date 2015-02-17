require "monitoring_service/version"
require "monitoring_service/api_client"
require "monitoring_service/log"
require "monitoring_service/memory"
require "monitoring_service/xmlrpc_server"
require "monitoring_service/xmlrpc_handler"

module MonitoringService
  def self.run
    threads = []
    threads << Thread.new do
      api_client = ApiClient.new
      loop do
        log = Log.new.collect
        api_client.send_log(log)
        #Hack: interval need to be configured
        sleep 2
      end
    end

    threads << Thread.new do
      XmlrpcServer.run
    end


    threads.each {|t| t.join }
  end
end
