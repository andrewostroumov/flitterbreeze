module MonitoringService
  class BlockDevice

    def collect
      @disks = df.scan /(\/dev\/sd\w\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+%)\s+(.*)/
      self
    end

    def disks
      @disks.map do |disk|
        {
          name: disk[0],
          total: disk[1].to_i,
          used: disk[2].to_i,
          available: disk[3].to_i,
          use: disk[4],
          mount_path: disk[5],
        }
      end
    end

    private

    def df
      @output ||= `df`
    end
  end
end
