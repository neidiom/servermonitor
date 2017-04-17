module ServerMonitor

  class PostfixMailq

    def self.run
      # Configure variables
      config = {
        path: "/opt/zimbra/common/sbin/postqueue -p",
        critical: 50,
        warning: 40
      }
      queue = `#{config[:path]} | /bin/grep -v 'Mail queue is empty' | /bin/grep -c '^[A-Z0-9]'`

      # Set the number of messages in the queue
      if queue == 0
        no_msg = 0
      else
        no_msg = queue.to_i
      end

      # Compare and return 0 for success and 1 for error
      if no_msg >= config[:critical].to_i
        puts "#{no_msg} messages in the postfix mail queue"
        puts exit 1
      elsif no_msg >= config[:warning].to_i
        puts "#{no_msg} messages in the postfix mail queue"
        puts exit 1
      else
        puts "#{no_msg} messages in the postfix mail queue"
        puts exit 0
      end
    end

  end

end
