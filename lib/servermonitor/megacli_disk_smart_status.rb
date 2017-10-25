require 'servermonitor/mail'

module ServerMonitor

  class DiskSMARTConfiguration
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

  class MegaCliDiskSMARTStatus
    def self.config
      @config ||= DiskSMARTConfiguration.new
    end

    def self.configure
      yield(config)
    end

    def self.run
      # Get current hostname
      fhostname = `hostname -f`

      # Get the status for each disk from megacli binary and grep for "Drive has flagged a S.M.A.R.T alert" keyword
      raid_status = `#{self.config.megacli} -LDInfo -Lall -aALL | #{self.config.grep} "Drive has flagged a S.M.A.R.T alert"`

      # Define eympty array
      in_in = []

      # Define empty variable for raid state
      smart_status = nil

      #
      raid_status.each_line { |l| in_in << l.chomp }

      # Check S.M.A.R.T status
      in_in.each do |i|
        # Regex matching
        Regexp.new('Drive\s*has\s*flagged\s*a\s*S\.M\.A\.R\.T\s*alert\s*:\s*Yes').match?(i) ? smart_status = "ALERT: YES".upcase : smart_status = "ALERT: NO".upcase
        # Display S.M.A.R.T Status and do a clean exit if parameter exit_codes is enabled
        if smart_status == "ALERT: NO"
          puts "S.M.A.R.T drive status is " + smart_status.to_s + " on hostname " + fhostname
          puts exit 0 unless self.config.exit_codes == false
        else
          # Display S.M.A.R.T Status and exit with error if exit_codes parameter is enabled
          puts "S.M.A.R.T drive status is " + smart_status.to_s + " on hostname " + fhostname
          puts exit 1 unless self.config.exit_codes == false
        end
        # Send email if email_to address is not empty AND if a disk does not return an "Alert: NO"
        if self.config.email_to != nil && smart_status != "ALERT: NO"
          time    = Time.now.strftime("%d.%m.%Y %H:%M")
          subject = "RAID check STARTED on #{fhostname} at #{time}. RAID STATE: #{smart_status}."
          body    = "RAID check: #{smart_status}"
          email   = ServerMonitor::EMail.new(self.config.email_from, self.config.email_to, self.config.smtp_address, self.config.smtp_port, self.config.smtp_username, self.config.smtp_password, subject, body)
          email.deliver
        end
      end
    end
  end
end
