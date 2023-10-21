#!/bin/bash
sleep 2

cd /home/container
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`
rm start.sh
curl -Lo ./start.sh https://gitlab.com/samcozza03/pterodactyl-vps-egg/raw/main/start.sh
chmod +x ./start.sh

# Install SSH server
apt-get update
apt-get install -y openssh-server

# Configure SSH
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config

# Set root password to "9099"
echo "root:9099" | chpasswd

# Restart SSH service
service ssh restart

# Run the Server
bash ./start.sh
