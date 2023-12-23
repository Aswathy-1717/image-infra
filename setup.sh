#!/bin/bash

# Update SSHD configuration for session keepalive
echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
systemctl restart sshd.service

# Install Apache (httpd) and PHP
yum install httpd php -y

# Create a health check HTML file
echo "testing" > /var/www/html/health.html

# Create PHP index file with system hostname and application version
cat <<EOF > /var/www/html/index.php
<?php
\$output = shell_exec('hostname');
echo "<h1><center><pre>\$output</pre></center></h1>";
echo "<h1><center>Shopping-Application-Version1</center></h1>";
?>
EOF

