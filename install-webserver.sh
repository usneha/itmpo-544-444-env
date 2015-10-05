#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y apache2 git


git clone https://github.com/usneha/itmo-544-444-env.git 

mv ./itmo-544-444-env/page2.html  /var/www/html

mv ./itmo-544-444-env/index.html /var/www/html

echo "Hello" > /tmp/hello.txt
