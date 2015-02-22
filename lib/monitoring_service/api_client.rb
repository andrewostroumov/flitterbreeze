require 'rest_client'

module MonitoringService
  class ApiClient
    def initialize
      @snapshots_url = "#{MonitoringService.settings['resource']}/snapshots"   
      @servers_url = "#{MonitoringService.settings['resource']}/servers"
      @resource = RestClient::Resource.new "#{MonitoringService.settings['resource']}/snapshots", { accept: :json }
    end

    def send_snapshot(snapshot)
      resource = resource(@snapshots_url)
      resource.post snapshot.to_h, content_type: :json, 'X-Server-Token' => MonitoringService.settings['server_token']
      puts "Sended snapshot #{snapshot.to_h} to #{resource.url}"
    end

    def send_server_general
      server = Server.new
      resource = resource("#{@servers_url}/update")
      resource.patch({ server: server.general }, content_type: :json, 'X-Server-Token' => MonitoringService.settings['server_token'])
      puts "Sended server general info #{server.general} to #{resource.url}"
    end

    def resource(url)
      RestClient::Resource.new url, { accept: :json }
    end
  end
end
