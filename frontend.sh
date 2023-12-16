log_file=/tmp/expense.log
colour="\e[36m"

echo -e "${colour} Installing nginx \e[0m"
dnf install nginx -y &>>log_file
if [ $? -eq 0 ]; then
  echo success
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo failure
  echo -e "\e[32m FAILURE \e[0m"
fi

echo -e "${colour}copy expense.conf file \e[0m"
cp expense.conf  /etc/nginx/default.d/expense.conf &>>log_file
if [ $? -eq 0 ]; then
  echo success
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo failure
  echo -e "\e[32m FAILURE \e[0m"
fi

echo -e "${colour} Installing nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>>log_file
if [ $? -eq 0 ]; then
  echo success
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo failure
  echo -e "\e[32m FAILURE \e[0m"
fi

echo -e "${colour}download & extract the fronend file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
if [ $? -eq 0 ]; then
  echo success
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo failure
  echo -e "\e[32m FAILURE \e[0m"
fi
echo -e "${colour} changing the dir \e[0m"
cd /usr/share/nginx/html &>>log_file
if [ $? -eq 0 ]; then
  echo success
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo failure
  echo -e "\e[32m FAILURE \e[0m"
fi
echo -e "${colour} Unzip the frontend zip \e[0m"
unzip /tmp/frontend.zip &>>log_file
if [ $? -eq 0 ]; then
  echo success
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo failure
  echo -e "\e[32m FAILURE \e[0m"
fi
echo -e "${colour} enable & restart the nginx \e[0m"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
if [ $? -eq 0 ]; then
  echo success
  echo -e "\e[32m SUCCESS \e[0m"
else
  echo failure
  echo -e "\e[32m FAILURE \e[0m"
fi