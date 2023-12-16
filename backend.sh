log_file=/tmp/expense.log
colour="\e[36m"

echo -e "${colour} disable the nodejs \e[0m"
dnf module disable nodejs -y &>>log_file
echo $?
echo -e "${colour} enable the nodejs \e[0m"
dnf module enable nodejs:18 -y &>>log_file
echo $?
echo -e "${colour} install the nodejs \e[0m"
dnf install nodejs -y &>>log_file
echo $?
echo -e "${colour} copy the backendservice \e[0m"
cp backend.service  /etc/systemd/system/backend.service &>>log_file
echo $?
echo -e "${colour} adding the expense file \e[0m"
useradd expense &>>log_file
echo $?
echo -e "${colour} creating the folder /app \e[0m"
mkdir /app &>>log_file
echo $?
echo -e "${colour} download & extract the backend zip file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
echo $?
echo -e "${colour} changing the directory to /app \e[0m"
cd /app &>>log_file
echo $?
echo -e "${colour} unzip the backend.zip file \e[0m"
unzip /tmp/backend.zip &>>log_file
echo $?
echo -e "${colour} changing the directory \e[0m"
cd /app &>>log_file
npm install &>>log_file
echo $?
echo -e "${colour} installing the mysql \e[0m"
dnf install mysql -y &>>log_file
echo $?
echo -e "${colour} mysql username \e[0m"
mysql -h mysql-dev.osdevops99.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
echo $?
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file
echo $?