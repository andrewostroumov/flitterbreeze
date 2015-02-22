require 'singleton'

module MonitoringService
  class Config
    include Singleton

    attr_accessor :setting

    def load
      @setting ||= YAML.load_file("#{ENV['HOME']}/.monitoring_config")
      self
    end
  end
end
