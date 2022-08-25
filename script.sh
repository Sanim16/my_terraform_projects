#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
# sudo su
# sudo mkdir /var/www/html/hi #create a subdirectory for path based routing
# sudo echo "Hello World from default path $(hostname -f)" > /var/www/html/index.html
# sudo echo "Hello World from hi path $(hostname -f)" > /var/www/html/hi/index.html #index file for path based directory


