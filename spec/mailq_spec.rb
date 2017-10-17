require 'spec_helper'
require 'servermonitor/mailq'

describe ServerMonitor::MailqConfiguration do
  it "Creates new instance of the Configuration class with default parameter values" do
    config = ServerMonitor::MailqConfiguration.new
    expect(config.path).to be       == "/opt/zimbra/common/sbin/postqueue -p"
    expect(config.grep).to be       == "/bin/grep"
    expect(config.critical).to be   == 50
    expect(config.warning).to be    == 40
    expect(config.exit_codes).to be == true
  end
end
