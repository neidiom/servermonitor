# Ruby Server Monitor
Collection of ruby server monitoring scripts

## Intended to use with [monit](https://mmonit.com/monit/)

### Example monit configuration to check postfix mailqueue
* find out path of binary with ``which postmailq ``
* put script in ``/etc/monit/conf.d/chech_mail-queue ``

```
check program CheckMailQueue path "/home/nedim/.rvm/gems/ruby-2.4.1/bin/postmailq"
    if status != 0 then alert
```

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

# Manually build the ServerMonitor gems
```
gem build servermonitor.gemspec
ls *.gem
gem install servermonitor-0.0.3.4.gem
``
