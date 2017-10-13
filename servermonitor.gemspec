lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "servermonitor/version"

Gem::Specification.new do |gem|
  gem.name        = 'servermonitor'
  gem.version     = ServerMonitor::VERSION
  gem.date        = '2017-04-17'
  gem.summary     = "Server Monitor"
  gem.description = "A collection of server monitoring ruby scripts packaged in a gem"
  gem.authors     = ["Nedim Hadzimahmutovic"]
  gem.email       = 'h.nedim@gmail.com'
  gem.files       = ["lib/servermonitor.rb","lib/servermonitor/version.rb","lib/servermonitor/mailq.rb","lib/servermonitor/megacli_vd_status.rb"]
  gem.homepage      = "https://github.com/neidiom/servermonitor"
  gem.require_paths = ["lib"]
  gem.executables   = %w(servermonitor postmailq)
  gem.license       = 'MIT'
end
