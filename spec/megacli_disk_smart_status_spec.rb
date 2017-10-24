require 'spec_helper'
require 'servermonitor/megacli_disk_smart_status'

describe ServerMonitor::DiskSMARTConfiguration do
  it "Creates a new instance of the DiskSMARTConfiguration class with default parameter values" do
    config = ServerMonitor::DiskSMARTConfiguration.new
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

describe ServerMonitor::MegaCliDiskSMARTStatus do
  it "Configures the MegaCliDiskSMARTStatus class method" do
    ServerMonitor::MegaCliDiskSMARTStatus.configure do |config|
      config.megacli        = "/usr/sbin/megacli"
      config.grep           = "/usr/bin/grep"
      config.exit_codes     = false
      config.email_to       = "example@example.to"
      config.email_from     = "example@example.from"
      config.smtp_address   = "server"
      config.smtp_port      = "25"
      config.smtp_username  = "username"
      config.smtp_password  = "password"
    end
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.megacli).to be       == "/usr/sbin/megacli"
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.grep).to be          == "/usr/bin/grep"
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.email_to).to be      == "example@example.to"
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.email_from).to be    == "example@example.from"
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.smtp_address).to be  == "server"
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.smtp_port).to be     == "25"
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.smtp_username).to be == "username"
    expect(ServerMonitor::MegaCliDiskSMARTStatus.config.smtp_password).to be == "password"
  end
end
