# connect
```
sudo mysql -u root
or
mysql -u root -p
```
# Create user
```CREATE USER 'new_user'@'%%' IDENTIFIED BY 'new_password';```
### Set permission read only
```sql
GRANT SELECT, SHOW VIEW ON databasename.* TO 'username'@'%%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```
### Check user exited
> LECT User, Host FROM mysql.user;
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
