https://github.com/mperham/sidekiq/blob/master/examples/systemd/sidekiq.service
https://github.com/mperham/sidekiq/blob/master/examples/upstart/workers.conf
https://github.com/mperham/sidekiq/blob/master/examples/upstart/sidekiq.conf
# Rails setup
```ruby
# Background job framework
gem 'sidekiq', '~> 6.1', '>= 6.1.2'
gem 'sidekiq-cron', '~> 1.2'
```
> Add file config/sidekiq.yml
```ruby
# Reference 
# https://github.com/mperham/sidekiq/blob/master/examples/config.yml
# https://github.com/mperham/sidekiq/wiki/Advanced-Options
:verbose: false
:concurrency: 10
:timeout: 25

:queues:
  - critical
  - default
  - low

production:
  :concurrency: 25
development:
  :concurrency: 15
```
# Setup by systemd
Add file sidekiq.service to systemd folder. This file tells systemd how to run Sidekiq as a 24/7 long-running daemon.
### How to run
> 
>
> /usr/lib/systemd/system (CentOS) 
>
> /lib/systemd/system (Ubuntu)
- systemctl enable sidekiq
- systemctl {start,stop,restart} sidekiq
### Config

# Sidekiq service
```ruby
[Unit]
Description=sidekiq
After=syslog.target network.target
[Service]
Type=notify
# If your Sidekiq process locks up, systemd's watchdog will restart it within seconds.
WatchdogSec=10

WorkingDirectory=/home/ruby/bacsi24h.qrmartdemo.info
# If you use rvm in production without gemset and your ruby version is 2.6.5
# ExecStart=/home/deploy/.rvm/gems/ruby-2.6.5/wrappers/bundle exec sidekiq -e production
# If you use rvm in production wit gemset and your ruby version is 2.6.5
ExecStart=/usr/local/rvm/rubies/ruby-2.6.3/lib/ruby/gems/2.6.0@gemset-name/wrappers/bundle exec sidekiq -e production

User=deploy
Group=deploy
UMask=0002

# Greatly reduce Ruby memory fragmentation and heap usage
# https://www.mikeperham.com/2018/04/25/taming-rails-memory-bloat/
Environment=MALLOC_ARENA_MAX=2

# if we crash, restart
RestartSec=1
Restart=on-failure

# output goes to /var/log/syslog (Ubuntu) or /var/log/messages (CentOS)
StandardOutput=syslog
StandardError=syslog

# This will default to "bundler" if we don't specify it
SyslogIdentifier=sidekiq

[Install]
WantedBy=multi-user.target
 ```


https://gist.github.com/nghuuphuoc/7801123