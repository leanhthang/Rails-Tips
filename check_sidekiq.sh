#!/bin/bash
echo "starting check sidekiq"

process=`cat /home/ec2-user/projects/kiman_crm/current/tmp/pids/sidekiq.pid`

processConfirmation=`ps aux | awk '{print $2 }' | grep $process`

if [ -z $processConfirmation ]
then
  echo "oops! not running... restarting sidekiq"
  cd /home/ec2-user/projects/kiman_crm/current/ && RAILS_ENV=production bundle exec  sidekiq -d -P tmp/pids/sidekiq.pid
fi

echo "finished sidekiq check"

# Set crontab
# edit crontab: crontab -e
# Run job check sidekiq process per minutes
# * * * * * source ~/.check_sidekiq.sh
# Check crobtab list available
# crontab -l
