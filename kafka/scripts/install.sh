#!/bin/bash

echo 'INSTALLER: Started up'

# Change root user
if [ "$VM_PASSWORD" = "" ]; then
  VM_PASSWORD='root'
fi

echo "root password: $VM_PASSWORD"
echo "$VM_PASSWORD" | passwd --stdin root
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
/sbin/service sshd restart

echo "YUM update"
echo "sslverify=false" >> /etc/yum.conf
yum update
yum upgrade -y

# fix locale warning
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

# install jdk
echo 'Install JDK'
yum install -y java-1.8.0-openjdk

# add kafka user
echo 'Install kafka'
useradd kafka -d /opt/kafka

# install kafka 2.13-3.1.0
su -l kafka -c "tar xzvf /vagrant/kafka_2.13-3.1.0.tgz -C /opt/kafka"
su -l kafka -c "ln -s kafka_2.13-3.1.0 kafka"
su -l kafka -c "echo 'export KAFKA_HOME=\$HOME/kafka' >> .bashrc"
su -l kafka -c "echo 'export PATH=\$PATH:\$KAFKA_HOME/bin' >> .bashrc"
su -l kafka -c "zookeeper-server-start.sh -daemon \$KAFKA_HOME/config/zookeeper.properties"
su -l kafka -c "kafka-server-start.sh -daemon \$KAFKA_HOME/config/server.properties"

