echo -e "\e[36m Installing nginx \e[0m"
dnf install nginx -y &>>/tmp/expense.log

echo -e "\e[36m copy expense.conf file \e[0m"
cp expense.conf  /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
echo -e "\e[36m Installing nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log

echo -e "\e[36m download & extract the fronend file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log

echo -e "\e[36m changing the dir \e[0m"

cd /usr/share/nginx/html &>>/tmp/expense.log

echo -e "\e[36m Unzip the frontend zip \e[0m"

unzip /tmp/frontend.zip &>>/tmp/expense.log

echo -e "\e[36m enable & restart the nginx \e[0m"

systemctl enable nginx &>>/tmp/expense.log
systemctl restart nginx &>>/tmp/expense.log
