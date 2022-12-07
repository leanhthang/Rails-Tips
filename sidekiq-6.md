# Install redis 6
https://www.howtoforge.com/how-to-install-and-secure-redis-on-centos-7/
# Reference:
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
> RUN after create: systemctl daemon-reload 

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

# Some error: 
```journalctl -xe
/usr/bin/env: ruby_executable_hooks: No such file or directory
sudo gem install --user-install executable-hooks
```
## Rails Sidekiq commandline
# Clear counter of failed and processed
Sidekiq::Stats.new.reset('failed', 'processed')
# Show all queue
Sidekiq::Queue.all
# Clear Queue
Sidekiq::Queue.all.map(&:clear)
# Clear all redis
Sidekiq.redis(&:flushdb)


<!-- SETUP MULTIPLE SERTVER -->

```ruby
This gem does support systemd and sidekiq 6.0 but currently sidekiq is locked to version < 6, so I've created fork which allow to use newest sidekiq 6.0.3: https://github.com/rwojnarowski/capistrano-sidekiq

In short, to get this gem working with sidekiq 6.0:
In Gemfile:
gem "capistrano-sidekiq", git: "https://github.com/rwojnarowski/capistrano-sidekiq.git"
In deploy.rb:
set :init_system, :systemd
On your server:
loginctl enable-linger USERACCOUNT
From repo directory run:
bundle exec cap sidekiq:install
You may need to enable new service on your server, so:
systemctl --user enable sidekiq-production
systemctl --user start sidekiq-production
Check the status:
systemctl --user status sidekiq-production
and deploy new app as usual with Capistrano

```
