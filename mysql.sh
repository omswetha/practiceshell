source common.sh

echo -e "${colour} disable the mysql \e[0m"
dnf module disable mysql -y &>>log_file
status_check
echo -e "${colour} cp mysql.repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
status_check
echo -e "${colour} Installing the nginx \e[0m"
dnf install mysql-community-server -y &>>log_file
status_check
echo -e "${colour} enable the mysql \e[0m"
systemctl enable mysqld &>>log_file
status_check
echo -e "${colour} start the mysqld \e[0m"
systemctl start mysqld &>>log_file
status_check
echo -e "${colour} setting the password for db \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
status_check

