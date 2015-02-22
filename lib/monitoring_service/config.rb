require 'singleton'

module MonitoringService
  class Config
    include Singleton

    class << self
      attr_accessor :path
    end

    self.path = "#{ENV['HOME']}/.monitoring_config"

    def settings
      @settings ||= YAML.load_file(self.class.path)
    end

    def update(settings)
      self.settings.merge! settings
      File.open(self.class.path, 'w') do |f| 
        f.puts self.settings.to_yaml
      end
    end
  end
end
