echo -e "\e[36m disable the mysql \e[0m"
dnf module disable mysql -y &>>/tmp/expense.log
echo -e "\e[36m cp mysql.repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/expense.log
echo -e "\e[36m Installing the nginx \e[0m"
dnf install mysql-community-server -y &>>/tmp/expense.log
echo -e "\e[36m enable the mysql \e[0m"
systemctl enable mysqld &>>/tmp/expense.log
echo -e "\e[36m start the mysqld \e[0m"
systemctl start mysqld &>>/tmp/expense.log
echo -e "\e[36m setting the password for db \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log

