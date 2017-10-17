require 'spec_helper'
require 'servermonitor'

describe ServerMonitor.welcome do
  it "Should return a Welcome, this is ServerMonitor greeting" do
    expect(ServerMonitor.welcome).to be == "Welcome, this is ServerMonitor!"
  end
end
