require "monitoring_service/version"
require "monitoring_service/config"
require "monitoring_service/api_client"
require "monitoring_service/snapshot"
require "monitoring_service/memory"
require "monitoring_service/processor"
require "monitoring_service/server"
require "monitoring_service/block_device"
require "monitoring_service/xmlrpc/server"
require "monitoring_service/xmlrpc/handler"
require 'pry'
require 'yaml'

module MonitoringService
  
  class << self
    attr_accessor :config
  end

  
  def self.run
    @config = Config.instance
    threads = []
    threads << Thread.new do
      api_client = ApiClient.new
      if api_client.server_state == 'active'
        loop do
          snapshot = Snapshot.new.collect
          api_client.send_snapshot(snapshot)
          sleep config.settings['sending_data_interval']
        end
      end
    end

    threads << Thread.new do
      XMLRPC::Server.run
    end

    threads.each &:join
  end
end
