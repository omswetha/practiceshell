echo -e "\e[36m disable the nodejs \e[0m"
dnf module disable nodejs -y &>>/tmp/expense.log
echo -e "\e[36m enable the nodejs \e[0m"
dnf module enable nodejs:18 -y &>>/tmp/expense.log
echo -e "\e[36m install the nodejs \e[0m"
dnf install nodejs -y &>>/tmp/expense.log
echo -e "\e[36m copy the backendservice \e[0m"
cp backend.service  /etc/systemd/system/backend.service &>>/tmp/expense.log
echo -e "\e[36m adding the expense file \e[0m"
useradd expense &>>/tmp/expense.log
echo -e "\e[36m creating the folder /app \e[0m"
mkdir /app &>>/tmp/expense.log
echo -e "\e[36m download & extract the backend zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/expense.log
echo -e "\e[36m changing the directory to /app \e[0m"
cd /app &>>/tmp/expense.log
echo -e "\e[36m unzip the backend.zip file \e[0m"
unzip /tmp/backend.zip &>>/tmp/expense.log
echo -e "\e[36m changing the directory \e[0m"
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo -e "\e[36m installing the mysql \e[0m"
dnf install mysql -y &>>/tmp/expense.log
echo -e "\e[36m mysql username \e[0m"
mysql -h mysql-dev.osdevops99.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log

systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log