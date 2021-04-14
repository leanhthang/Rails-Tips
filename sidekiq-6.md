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
> detect gem path ```gem environment```

```ruby
# Ubuntu && RBENV
# Reference: https://github.com/mperham/sidekiq/blob/master/examples/systemd/sidekiq.service
[Unit]
Description=sidekiq
# start us only once the network and logging subsystems are available,
# consider adding redis-server.service if Redis is local and systemd-managed.
After=syslog.target network.target

[Service]
# As of v6.0.6, Sidekiq automatically supports systemd's `Type=notify` and watchdog service
# monitoring. If you are using an earlier version of Sidekiq, change this to `Type=simple`
# and remove the `WatchdogSec` line.
Type=notify
# If your Sidekiq process locks up, systemd's watchdog will restart it within seconds.
WatchdogSec=10
WorkingDirectory=/home/lat/advn/sunlight.acecom.vn
# If you use rvm in production without gemset and your ruby version is 2.6.5
# ExecStart=/home/deploy/.rvm/gems/ruby-2.6.5/wrappers/bundle exec sidekiq -e production
# If you use rvm in production wit gemset and your ruby version is 2.6.5
# detect gem path "gem environment" => 
# ExecStart=/usr/local/rvm/rubies/ruby-2.6.3/lib/ruby/gems/2.6.0@gemset-name/wrappers/bundle exec sidekiq -e production
ExecStart=/home/lat/.rbenv/shims/bundle exec sidekiq -C config/sidekiq.yml
User=lat
Group=root
UMask=0002

# Greatly reduce Ruby memory fragmentation and heap usage
Environment=MALLOC_ARENA_MAX=2
# Memory management
MemoryAccounting=true
MemoryHigh=35%
MemoryMax=50%

# if we crash, restart
RestartSec=1
Restart=on-failure

# output goes to /var/log/syslog
StandardOutput=syslog
StandardError=syslog

# This will default to "bundler" if we don't specify it
SyslogIdentifier=sidekiq

[Install]
WantedBy=multi-user.target

```

# Sidekiq service multiple services
https://gist.github.com/Loriowar/fdf8a379ba820de9dd55c97b6fa10594
