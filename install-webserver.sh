#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y apache2 git php5 php5-curl mysql-client curl php5-mysql


git clone https://github.com/usneha/itmpo-544-444-env.git 

mv ./itmpo-544-444-env/images  /var/www/html/images

mv ./itmpo-544-444-env/index.html /var/www/html

mv ./itmpo-544-444-env/*.php /var/www/html

curl -sS https://getcomposer.org/installer | sudo php &> /tmp/getcomposer.txt

sudo php composer.phar require aws/aws-sdk-php &> /tmp/runcomposer.txt

sudo mv vendor /var/www/html &> /tmp/movevendor.txt

echo "Hello" > /tmp/hello.txt
