#This is the data.sh file containing user data for the private instances.

#!/bin/bash
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "This is the test file for standalone database"  > /var/www/html/index.html

#This is the ec2-init.sh file containing user data for public instances

#!/bin/bash
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2
echo "This is the test file for web"  > /var/www/html/index.html
