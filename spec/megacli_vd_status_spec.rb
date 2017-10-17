require 'spec_helper'
require 'servermonitor/megacli_vd_status'

describe ServerMonitor::VDConfiguration do
  it "Creates new instance of Configuration class with default parameter values" do
    config = ServerMonitor::VDConfiguration.new
    expect(config.grep).to be             == "/bin/grep"
    expect(config.exit_codes).to be       == false
    expect(config.megacli).to be          == "/usr/sbin/megacli"
    expect(config.email_from).to be       == nil
    expect(config.email_to).to be         == nil
    expect(config.smtp_address).to be     == nil
    expect(config.smtp_port).to be        == nil
    expect(config.smtp_username).to be    == nil
    expect(config.smtp_password).to be    == nil
  end
end
