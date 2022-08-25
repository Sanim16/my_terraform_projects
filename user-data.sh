#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo mkdir /var/www/html/hi #create a subdirectory for path based routing
echo "Hello World from default path $(hostname -f)" > /var/www/html/index.html
echo "Hello world from Hi path $(hostname -f)" > /var/www/html/hi/index.html #index file for path based directory
sudo mkdir /var/www/html/bye #create a subdirectory for path based routing
echo "Bye and have a nice day from bye path $(hostname -f)" > /var/www/html/bye/index.html #index file for path based directory
