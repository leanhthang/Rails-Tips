
# Add ssh
> sshpass -p $password ssh-copy-id -i ~/.ssh/id_rsa.pub -p 22 $user@$server
# Remote control
## if use password to access
```bash
sshpass -p $password ssh $user@$server << EOF
  * write command
EOF 
```
## if use SSH key to access
```ruby
# deploy.sh
#!/bin/bash
# Set variables
password='abcxyz'
user='user123'
server=$1#'123.0.0.23'
pj_path='/home/user/project_path'
port=4000

ssh $user@$server << EOF
    cd $pj_path
    # Git  
    git checkout branch master
    git pull
    # Bundle + Node package
    bundle install
    yarn install
    # Compile assets
    RAILS_ENV=production bundle exec rails assets:precompile
    RAILS_ENV=production bundle exec rails db:migrate

    # Production: Start and Restart passenger
    bundle exec passenger start -e production -p $port
    bundle exec passenger-config restart-app /

    # For deploy multiple instances on servers (recommend for develop mode), Stop and start
    # bundle exec passenger stop $pj_path --pid-file $pj_path/tmp/pids/passenger.$port.lock
    # rm $pj_path/tmp/pids/*
    # bundle exec passenger start -e production -p $port
EOF
```
# When deploy multiple instances
## Initialize
## Deploy
* deploy.rb
```ruby
local_ssh = '~/.ssh/id_rsa.pub'
servers = [
        {
            ip: '53.213.3.21',
            password: 'abcxyz',
            ssh_key: 'path/key.pem'
        }, { ... }, ..
    ]
def deploy(kind)
    case kind
    when 'init'
        system(". deploy.sh #{serv}")
    when 'restart'
        system(". deploy.sh #{serv}")
    when 'ssh'
        servers.each do |serv|
            if serv[:password].present?
                system("sshpass -p #{serv[:password]} ssh-copy-id -i #{local_ssh} -p 22")
            elsif serv[:ssh_key].present?
                system("ssh-add #{serv[:ssh_key]}")
            else
                raise 'Missing password or ssh_key'
            end
        end
        system("sudo chmod 600 #{local_ssh}")
        system("eval (ssh-agent -s)")
        system("ssh-add #{local_ssh}")
    end
end

deploy(ARGV)
```
## run 
```ruby
# Add SSH
ruby deploy.rb ssh
# Initialize
ruby deploy.rb init
# Resatrt
ruby deploy.rb restart
```
