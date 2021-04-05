https://www.tecmint.com/install-logrotate-to-manage-log-rotation-in-linux/

# Script delete old backup 
```ruby
require 'fileutils'

folders = (Dir.entries(Dir.getwd) - ['.', '..']).sort.reverse.select{|x| x.to_i > 19900000 }
keep_backup_folders = folders[0..4]
delete_folders = folders - keep_backup_folders

delete_folders.each do |folder|
  FileUtils.remove_dir("#{Dir.getwd}/#{folder}")
end
```
