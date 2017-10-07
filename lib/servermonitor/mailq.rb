module ServerMonitor

  class Configuration
    attr_accessor :path, :grep, :critical, :warning

    def initialize
      @path = "/opt/zimbra/common/sbin/postqueue -p"
      @grep = "/usr/bin/grep"
      @critical = 50
      @warning = 40
    end
  end

  class Mailq

    def self.config
      @config ||= Configuration.new
    end

    def self.configure
      yield(config)
    end

    def self.run

      queue = "#{self.config.path} | #{self.config.grep} -v 'Mail queue is empty' | #{self.config.grep} -c '^[A-Z0-9]'"

      # Set the no_msg (number of messages) from queue variable if no_msg does not = 0
      queue == 0 ? no_msg = 0 : no_msg = queue.to_i

      # Compare and return 0 for success and 1 for error
      if no_msg >= self.config.critical.to_i
        puts "#{no_msg} messages in the postfix mail queue"
        puts exit 1
      elsif no_msg >= self.config.warning.to_i
        puts "#{no_msg} messages in the postfix mail queue"
        puts exit 1
      else
        puts "#{no_msg} messages in the postfix mail queue"
        puts exit 0
      end
    end
  end
end
