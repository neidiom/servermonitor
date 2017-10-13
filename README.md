# Ruby Server Monitor
This is a configurable Ruby gem providing a collection of server monitoring scripts.

### Current scripts provided
* Mailq - check number of messages in the server's mail queue
* MegaCliVDStatus - check the status of LSI RAID Controller Virtual Drive status

## Custom configuration example

### Configure Mailq script

```ruby
#!/usr/bin/env ruby -w

require "servermonitor/mailq"

ServerMonitor::Mailq.configure do |config|
  config.path = "/opt/zimbra/common/sbin/postqueue -p"
  config.grep = "/usr/bin/grep"
  config.exit_codes = false
end

ServerMonitor::Mailq.run
```

### Configure MegaCliVDStatus script

```ruby
#!/usr/bin/env ruby -w

require "servermonitor/megacli_vd_status"

ServerMonitor::MegaCliVDStatus.configure do |config|
  config.megacli = "/usr/sbin/megacli"
  config.grep = "/usr/bin/grep"
  config.exit_codes = false
end

ServerMonitor::MegaCliVDStatus.run
```

## Set exit_codes to true in order to use with [monit](https://mmonit.com/monit/)

### Example monit configuration to check postfix mailqueue
* find out path of binary with ``which postmailq ``
* put script in ``/etc/monit/conf.d/chech_mail-queue ``

```
check program CheckMailQueue path "/home/nedim/.rvm/gems/ruby-2.4.1/bin/postmailq"
    if status != 0 then alert
```
* replace ``/home/nedim/.rvm/gems/ruby-2.4.1/bin/postmailq`` with output you got from ``which postmailq ``

# Howto manually invoke

### Commands

```servermonitor```

```postmailq```

## Install with Bundler
Add to your Gemfile
```
gem 'servermonitor', git: 'https://github.com/neidiom/servermonitor.git'
```
Run bundler
```
bundle install
```

# Manually build the ServerMonitor gem
```
gem build servermonitor.gemspec
ls *.gem
gem install servermonitor-*.gem
```
