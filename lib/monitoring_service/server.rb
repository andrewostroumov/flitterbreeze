module MonitoringService
  class Server

    def distro_name
      @distro_name ||= lsb_release('Description')
    end

    def kernel_release
      @kernel_release ||= uname '-r'
    end

    def general
      {
        distro_name: distro_name,
        kernel_release: kernel_release
      }
    end

    private

    def uname(option)
      `uname #{option}`
    end

    def lsb_release(key)
      @lsb_release ||= `lsb_release -a`
      result = @lsb_release.scan /#{key}:\s*(.+)\s/
      result[0][0]
    end
  end
end
