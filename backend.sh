source common.sh

if [ -z "$1" ]; then
  echo password input is missing
  exit
fi

MYSQL_ROOT_PASSWORD=$1


echo -e "${colour} disable the nodejs \e[0m"
dnf module disable nodejs -y &>>log_file
status_check
echo -e "${colour} enable the nodejs \e[0m"
dnf module enable nodejs:18 -y &>>log_file
status_check
echo -e "${colour} install the nodejs \e[0m"
dnf install nodejs -y &>>log_file
status_check
echo -e "${colour} copy the backendservice \e[0m"
cp backend.service  /etc/systemd/system/backend.service &>>log_file
status_check

id expense &>>$log_file
if [ $? -ne 0 ]; then
 echo -e "${colour} adding the expense file \e[0m"
 useradd expense &>>log_file
 if [ $? -eq 0 ]; then
   echo -e "\e[32m SUCCESS \e[0m"
 else
   echo -e "\e[32m FAILURE \e[0m"
  fi
fi

if [ ! -d /app ]; then
echo -e "${colour} creating the folder /app \e[0m"
mkdir /app &>>log_file
 if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
 else
   echo failure
   echo -e "\e[32m FAILURE \e[0m"
 fi
fi

echo -e "${colour} creating the folder /app \e[0m"
rm -rf /app/* &>>log_file
echo -e "${colour} download & extract the backend zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
status_check
echo -e "${colour} changing the directory to /app \e[0m"
cd /app &>>log_file
status_check
echo -e "${colour} unzip the backend.zip file \e[0m"
unzip /tmp/backend.zip &>>log_file
status_check
echo -e "${colour} changing the directory \e[0m"
cd /app &>>log_file
npm install &>>log_file
status_check
echo -e "${colour} installing the mysql \e[0m"
dnf install mysql -y &>>log_file
status_check
echo -e "${colour} mysql username \e[0m"
mysql -h mysql-dev.osdevops99.online -uroot -p${MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>log_file
status_check
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file
status_check