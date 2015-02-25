require 'json'

module MonitoringService
  class Snapshot
    def collect
      @memory = Memory.new.collect
      @processor = Processor.new.collect
      @block_device = BlockDevice.new.collect
      self
    end

    def to_h
      {
        snapshot: {
          memory: @memory.to_h,
          cpu: @processor.to_h,
          disks: @block_device.disks
        }
      }
    end
  end
end
