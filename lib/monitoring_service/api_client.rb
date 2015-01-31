require 'rest_client'

module MonitoringService
  class ApiClient

    def initialize
      #Hack: CONFIG
      @resource ||= RestClient::Resource.new 'http://127.0.0.1:3000/log', { accept: :json }
    end

    def send_log(log)
      @resource.post log.to_json, content_type: :json
    end

  end
end
