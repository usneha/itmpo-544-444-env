#!/bin/bash

sudo apt-get update -y
sudo apt-get install-y apache2 git


 git clone https://github.com/usneha/itmo-544-444-fall-2015.git 

mv ./itmo-544-444-fall-2015/images/ /var/www/html/images

mv ./itmo-544-444-fall-2015/index.html /var/www/html

echo "Hello" > /tmp/hello.txt
