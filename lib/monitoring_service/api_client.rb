require 'rest_client'

module MonitoringService
  class ApiClient
    def initialize
      #Hack: CONFIG
      @resource ||= RestClient::Resource.new MonitoringService.setting['api'], { accept: :json }
    end

    def send_snapshot(snapshot)
      puts "Sending snapshot #{snapshot.to_json} to #{@resource.url}"
      @resource.post snapshot.to_json, content_type: :json, 'X-Server-Token' => 'EjbvoxbaPfgVVKRwVYLz'
    end
  end
end
