# Ruby Server Monitor
This is a configurable Ruby gem providing a collection of server monitoring scripts.

### Current scripts provided
* Mailq - check number of messages in the server's mail queue
* MegaCliVDStatus - check the status of LSI RAID Controller Virtual Drive
* MegaCliDiskSMARTStatus - check if disk returns a S.M.A.R.T alert

## Custom configuration example

### Configure MailQ script

```ruby
#!/usr/bin/env ruby -w

require "servermonitor/mailq"

ServerMonitor::Mailq.configure do |config|
  config.path       = "/opt/zimbra/common/sbin/postqueue -p"
  config.grep       = "/usr/bin/grep"
  config.exit_codes = false
end

ServerMonitor::Mailq.run
```

### Configure MegaCliVDStatus script

#### Output VD (Virtual Drive) status to STDOUT

```ruby
#!/usr/bin/env ruby -w

require "servermonitor/megacli_vd_status"

ServerMonitor::MegaCliVDStatus.configure do |config|
  config.megacli    = "/usr/sbin/megacli"
  config.grep       = "/usr/bin/grep"
  config.exit_codes = false
end

ServerMonitor::MegaCliVDStatus.run
```
#### Send VD (Virtual Drive) status to email

```ruby
#!/usr/bin/env ruby -w

require "servermonitor/megacli_vd_status"

ServerMonitor::MegaCliVDStatus.configure do |config|
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

ServerMonitor::MegaCliVDStatus.run
```

### Configure MegaCliDiskSMARTStatus script

#### Output disk S.M.A.R.T alerts to STDOUT

```ruby
#!/usr/bin/env ruby -w

require "servermonitor/megacli_disk_smart_status"

ServerMonitor::MegaCliDiskSMARTStatus.configure do |config|
  config.megacli        = "/usr/sbin/megacli"
  config.grep           = "/usr/bin/grep"
  config.exit_codes     = false
end

ServerMonitor::MegaCliDiskSMARTStatus.run
```
#### Send disk S.M.A.R.T alerts to email

```ruby
#!/usr/bin/env ruby -w

require "servermonitor/megacli_disk_smart_status"

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

ServerMonitor::MegaCliDiskSMARTStatus.run
```


# Use with external monitoring systems
## Set exit_codes to true in order to use with [monit](https://mmonit.com/monit/)

### Example monit configuration to check postfix mailqueue
* find out path of binary with ``which postmailq ``
* put script in ``/etc/monit/conf.d/chech_mail-queue ``

```
check program CheckMailQueue path "/home/nedim/.rvm/gems/ruby-2.4.2/bin/postmailq"
    if status != 0 then alert
```
* replace ``/home/nedim/.rvm/gems/ruby-2.4.2/bin/postmailq`` with output you got from ``which postmailq ``

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
