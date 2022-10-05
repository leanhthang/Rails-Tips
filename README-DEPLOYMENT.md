## Preparing the environment

* RVM latest version
* Node latest version
* Ruby version : 2.7.2
* Proxy server : Nginx
* Application server : Passenger Open Source
* Must-Have Passenger dynamic Nginx module : `nginx-mod-http-passenger` | How to install?

```html
  sudo yum install -y nginx-mod-http-passenger || { sudo yum-config-manager --enable cr && sudo yum install -y nginx-mod-http-passenger ; }

```

## Before deploy

* Generate your SSH key on your laptop(if it doesn't exist)
* Read your SSH key `cat ~/.ssh/id_rsa.pub` and copy it
* With each servers, you have to paste your SSH key to file `~/.ssh/authorized_keys` in `a new line`

## How to deploy

* Commit/Merge new code to `master` branch

* Run below comment to deploy your new code to the servers
```html
 bundle exec cap production deploy
```

* Run below comment to restart the servers
```html
 bundle exec cap production deploy:restart
```

## Logrotate

* Install Logrotate
```html
 sudo yum update && sudo yum install logrotate
```

### Configuring Logrotate For Rails Production Logs
* Create file `rails_oms` inside `/etc/logrotate.d/` folder
* Copy & Paste the code below into file `rails_oms`
```html
  /home/ruby/app_dir/current/log/*.log {
    daily
    minsize 500M
    missingok
    rotate 5
    compress
    delaycompress
    notifempty
    copytruncate
  }
```

* Running Logrotate for testing
```html
sudo /usr/sbin/logrotate -f /etc/logrotate.d/rails_oms
```
