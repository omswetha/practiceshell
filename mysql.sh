echo -e "\e[36m disable the mysql \e[0m"
dnf module disable mysql -y
echo -e "\e[36m cp mysql.repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m Installing the nginx \e[0m"
dnf install mysql-community-server -y
echo -e "\e[36m enable the mysql \e[0m"
systemctl enable mysqld
echo -e "\e[36m start the mysqld \e[0m"
systemctl start mysqld
echo -e "\e[36m setting the password for db \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1

