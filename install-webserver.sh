#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y apache2 git


git clone https://github.com/usneha/itmpo-544-444-env.git 

mv ./itmpo-544-444-env/page2.html  /var/www/html

mv ./itmpo-544-444-env/index.html /var/www/html

echo "Hello" > /tmp/hello.txt
