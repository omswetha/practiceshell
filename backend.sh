echo -e "\e[36m disable the nodejs \e[0m"
dnf module disable nodejs -y
echo -e "\e[36m enable the nodejs \e[0m"
dnf module enable nodejs:18 -y
echo -e "\e[36m install the nodejs \e[0m"
dnf install nodejs -y
echo -e "\e[36m copy the backendservice \e[0m"
cp backend.service  /etc/systemd/system/backend.service
echo -e "\e[36m adding the expense file \e[0m"
useradd expense
echo -e "\e[36m creating the folder /app \e[0m"
mkdir /app
echo -e "\e[36m download & extract the backend zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
echo -e "\e[36m changing the directory to /app \e[0m"
cd /app
echo -e "\e[36m unzip the backend.zip file \e[0m"
unzip /tmp/backend.zip
echo -e "\e[36m changing the directory \e[0m"
cd /app
npm install
echo -e "\e[36m installing the mysql \e[0m"
dnf install mysql -y
echo -e "\e[36m mysql username \e[0m"
mysql -h mysql-dev.osdevops99.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

systemctl daemon-reload
systemctl enable backend
systemctl restart backend