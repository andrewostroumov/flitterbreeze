require 'rest_client'

module MonitoringService
  class ApiClient
    def initialize
      @snapshots_url = "#{MonitoringService.config.settings['resource']}/snapshots"
      @server_url = "#{MonitoringService.config.settings['resource']}/server"
    end

    def server_state
      resource = RestClient::Resource.new @server_url, { accept: :json }
      begin
        result = resource.get 'X-Server-Token' => MonitoringService.config.settings['server_token']
        JSON.parse(result)['state']
      rescue RestClient::Unauthorized => e
      end  
    end

    def send_snapshot(snapshot)
      resource = RestClient::Resource.new @snapshots_url, { accept: :json }
      resource.post snapshot.to_h.to_json, content_type: :json, 'X-Server-Token' => MonitoringService.config.settings['server_token']
      puts "Sended snapshot #{snapshot.to_h} to #{resource.url}"
      self
    end

    def send_server_general
      server = Server.new
      resource = RestClient::Resource.new "#{@server_url}/update", { accept: :json }
      resource.patch({ server: server.general }, content_type: :json, 'X-Server-Token' => MonitoringService.config.settings['server_token'])
      puts "Sended server general info #{server.general} to #{resource.url}"
      self
    end
  end
end
