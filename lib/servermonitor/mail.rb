require 'mail'

module ServerMonitor
  class EMail
    def initialize(email_from, email_to, smtp_address, smtp_port, smtp_username, smtp_password, subject, body)
      @email_from    = email_from
      @email_to      = email_to
      @smtp_address  = smtp_address
      @smtp_port     = smtp_port
      @smtp_username = smtp_username
      @smtp_password = smtp_password
      @subject       = subject
      @body          = body
    end
    def deliver
      mail = Mail.new do
      end
      mail['from']   = @email_from
      mail['to']     = @email_to
      mail.subject   = @subject
      mail.body      = @body
      mail.delivery_method :smtp, address: @smtp_address, port: @smtp_port, user_name: @smtp_username, password: @smtp_password
      puts mail.deliver!
    end
  end
end
