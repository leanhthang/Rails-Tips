# connect
```
sudo mysql -u root
or
mysql -u root -p
```
# Create user
```CREATE USER 'new_user'@'%' IDENTIFIED BY 'new_password';```
### Set permission read only
```sql
GRANT SELECT, SHOW VIEW ON databasename.* TO 'username'@'%' IDENTIFIED BY 'password';
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
mysql -u [user] -p [database_name] < [filename].sql


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
