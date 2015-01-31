require "monitoring_service/version"
require "monitoring_service/api_client"
require "monitoring_service/log"
require "monitoring_service/memory"

module MonitoringService
  def self.process
    api_client = ApiClient.new
    loop do
      log = Log.new.collect
      api_client.send_log(log)
      #Hack: interval need to be configured
      sleep 2
    end
  end
end
