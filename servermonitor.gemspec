lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "servermonitor/version"


Gem::Specification.new do |gem|
  gem.name        = 'servermonitor'
  gem.version     = ServerMonitor::VERSION
  gem.date        = '2017-04-28'
  gem.summary     = "Server Monitor"
  gem.description = "A simple hello world gem"
  gem.authors     = ["Nedim Hadzimahmutovic"]
  gem.email       = 'h.nedim@gmail.com'
  gem.files       = ["lib/servermonitor.rb","lib/servermonitor/version.rb"]
  gem.homepage      = "https://github.com/neidiom/servermonitor"
  gem.require_paths = ["lib"]
  gem.executables   = %w(servermonitor)
  gem.license       = 'MIT'
end
