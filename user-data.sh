#!/bin/bash
sudo apt update -y
# sudo apt install -y apache2
# sudo systemctl start apache2
# sudo systemctl enable apache2
sudo apt install -y lamp-server^ php
sudo apt install -y php php-common libapache2-mod-php php-cli php-fpm php-mysql php-json php-opcache php-gmp php-curl php-intl php-mbstring php-xmlrpc php-gd php-xml php-zip
sudo systemctl start apache2
sudo systemctl enable apache2
# sudo mkdir /var/www/html/hi #create a subdirectory for path based routing
# echo "Hello World from default path $(hostname -f)" > /var/www/html/index.html
# echo "Hello world from Hi path $(hostname -f)" > /var/www/html/hi/index.html #index file for path based directory
# sudo mkdir /var/www/html/bye #create a subdirectory for path based routing
# echo "Bye and have a nice day from bye path $(hostname -f)" > /var/www/html/bye/index.html #index file for path based directory
mysql -h ${db_address} -u ${admin_user} -p${admin_password} -D mydb << eof
CREATE TABLE IF NOT EXISTS mydb (goal_id int NOT NULL AUTO_INCREMENT, goal_category int, goal_text varchar(255), goal_date date, goal_complete int, PRIMARY KEY (goal_id));
INSERT INTO mydb (goal_category, goal_text, goal_date, goal_complete) VALUES ('1', 'Sample Incomplete Goal to populate Database', '2022-09-30', '0');
INSERT INTO mydb (goal_category, goal_text, goal_date, goal_complete) VALUES ('1', 'Sample Complete Goal to populate Database', '2022-09-30', '1');
eof
