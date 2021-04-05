https://www.tecmint.com/install-logrotate-to-manage-log-rotation-in-linux/

# Script delete old backup 
```ruby
# Create file script_delete_old_backup.rb
require 'fileutils'

folders = (Dir.entries(Dir.getwd) - ['.', '..']).sort.reverse.select{|x| x.to_i > 19900000 }
keep_backup_folders = folders[0..4]
delete_folders = folders - keep_backup_folders

delete_folders.each do |folder|
  FileUtils.remove_dir("#{Dir.getwd}/#{folder}")
end
```
# Script create backup
```bash
####=========####
PATH_DSTAMP=$(date "+%d-%m-%Y_%H:%M:%S")
PATH_DATE=$(date "+%Y%m%d")
PJ_PATH=/home/ruby/sunlight.acecom.vn
BACKUP_PATH=/home/ruby/backup/$PATH_DATE
# Create backup folder
mkdir $BACKUP_PATH
mkdir $BACKUP_PATH/db
mkdir $BACKUP_PATH/sources
# Backup DB
sudo -u postgres /usr/pgsql-10/bin/pg_dump sunlight > $BACKUP_PATH/db/sunlight-$PATH_DSTAMP.sql
# Backup file
tar --exclude='.git' --exclude='vendor' --exclude='log' --exclude='tmp' -czvf $BACKUP_PATH/sources/sunlight_file.tar $PJ_PATH
# Destroy old file over 5 days
#cd $BACKUP_PATH/sources/ find . -mtime +5 -type f -print0 | xargs -0 rm
#cd $BACKUP_PATH/db/ find . -mtime +5 -type f -print0 | xargs -0 rm
ruby script_delete_old_backup.rb
```
