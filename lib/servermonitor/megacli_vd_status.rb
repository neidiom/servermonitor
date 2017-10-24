require 'servermonitor/mail'

module ServerMonitor

  class VDConfiguration
    attr_accessor :megacli, :grep, :exit_codes, :email_from, :email_to, :smtp_address, :smtp_port, :smtp_username, :smtp_password

    def initialize
      @megacli       = "/usr/sbin/megacli"
      @grep          = "/bin/grep"
      @exit_codes    = false
      @email_from    = nil
      @email_to      = nil
      @smtp_address  = nil
      @smtp_port     = nil
      @smtp_username = nil
      @smtp_password = nil
    end
  end

  class MegaCliVDStatus
    def self.config
      @config ||= VDConfiguration.new
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
        puts "Virtual drive status is " + vd_status.to_s + " on hostname " + fhostname
        puts exit 0 unless self.config.exit_codes == false
      else
        puts "Virtual drive status is " + vd_status.to_s + " on hostname " + fhostname
        puts exit 1 unless self.config.exit_codes == false
      end

      if self.config.email_to != nil
        time    = Time.now.strftime("%d.%m.%Y %H:%M")
        subject = "Daily RAID check STARTED on #{fhostname} at #{time}. RAID STATE: #{vd_status}."
        body    = "Daily RAID check: #{vd_status}"
        email   = ServerMonitor::EMail.new(self.config.email_from, self.config.email_to, self.config.smtp_address, self.config.smtp_port, self.config.smtp_username, self.config.smtp_password, subject, body)
        email.deliver
      end
    end
  end
end
