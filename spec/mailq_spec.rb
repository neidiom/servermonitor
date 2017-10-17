require 'spec_helper'
require 'servermonitor/mailq'

describe ServerMonitor::MailqConfiguration do
  it "Creates a new instance of the MailqConfiguration class with default parameter values" do
    config = ServerMonitor::MailqConfiguration.new
    expect(config.path).to be       == "/opt/zimbra/common/sbin/postqueue -p"
    expect(config.grep).to be       == "/bin/grep"
    expect(config.critical).to be   == 50
    expect(config.warning).to be    == 40
    expect(config.exit_codes).to be == true
  end
end

describe ServerMonitor::Mailq do
  it "Configures the Mailq class method" do
    ServerMonitor::Mailq.configure do |config|
      config.path       = "/usr/bin/mailq"
      config.grep       = "/usr/bin/grep"
      config.exit_codes = true
    end
    expect(ServerMonitor::Mailq.config.path).to be        == "/usr/bin/mailq"
    expect(ServerMonitor::Mailq.config.grep).to be        == "/usr/bin/grep"
    expect(ServerMonitor::Mailq.config.exit_codes).to be  == true
  end
end
