https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04

# Auto start after reboot
sudo update-rc.d mysql defaults
# connect
```
sudo mysql -u root
or
mysql -u root -p
```
# Create user
```
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'new_password';
ALTER USER 'userName'@'localhost' IDENTIFIED BY 'New-Password-Here';
```
### Set permission read only
```sql
GRANT SELECT, SHOW VIEW ON databasename.* TO 'username'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```
### Set Full permission
```sql
GRANT ALL PRIVILEGES ON 'yourDB'.* TO 'user1'@localhost IDENTIFIED BY 'password1';
FLUSH PRIVILEGES;
```
### Check user exited
> SELECT User, Host FROM mysql.user;
### Drop user
> DROP USER 'username'@'host';
# Change pass
```ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'insert_password';```
# Create database
```CREATE DATABASE testdb;```
# Backup
  sudo mysqldump -u [user] -p [database_name] > [filename].sql
## Skip table
  mysqldump -u USERNAME -p DATABASE --ignore-table=DATABASE.table1 > database.sql

# Restore
```If change database name
sed -i 's/`MYDATABASE`/`MYNEWDATABASE`/g' mydump.sql
``
mysql --verbose -u [user]  -p -D newdatabase < backup_file


<!-- Fix -->
# MYSQL Incorrect string value: '\xF0\x93\x80\x80'
```SQL
-- Change a database
ALTER DATABASE [database_name] 
  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci; 

-- Change a table
ALTER TABLE [table_name] 
  CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 

-- Change a column
ALTER TABLE [table_name] 
  CHANGE [column_name] [column_name] VARCHAR(255) 
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
# Show slow Query
## Active slow log
```SQL
-- Query 
SET GLOBAL slow_query_log = 1;
SET GLOBAL slow_query_log_file = 'db-slow.log'; 
SET GLOBAL long_query_time = 2; -- Set the threshold in seconds
-- Show status log
SHOW VARIABLES LIKE 'slow%';
SELECT @@slow_query_log_file;
```
## Find slow log 
```
# slow_query.log get from query SELECT @@slow_query_log_file
sudo find / -name "slow_query.log" -print
```
