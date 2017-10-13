module ServerMonitor

  class Configuration
    attr_accessor :megacli, :grep, :exit_codes

    def initialize
      @megacli = "/usr/sbin/megacli"
      @grep = "/bin/grep"
      @exit_codes = false
    end
  end

  class MegaCliVDStatus
    def self.config
      @config ||= Configuration.new
    end

    def self.configure
      yield(config)
    end

    def self.run
      # Get current hostname
      fhostname = `hostname -f`
      # Get the VD state from megacli binary and grep for "State" keyword
      raid_status = `#{self.config.megacli} -LDInfo -Lall -aALL | #{self.config.grep} "State"`
      # Define eympty array
      in_in = []
      # Define empty variable for raid state
      vd_status = nil
      #
      raid_status.each_line { |l| in_in << l.chomp }
      # Check virtual drive status
      in_in.each { |i| Regexp.new('State\s*:\s*Optimal').match?(i) ? vd_status = "Optimal".upcase : vd_status = "NOT Optimal".upcase }
      # Display VD Status
      if vd_status == "Optimal"
        puts "Virtual drive status is " + vd_status + " on hostname " + fhostname
        puts exit 0 unless self.config.exit_codes == false
      else
        puts "Virtual drive status is " + vd_status + " on hostname " + fhostname
        puts exit 1 unless self.config.exit_codes == false
      end
    end
  end
end
