#!/bin/bash

echo 'INSTALLER: Started up'

# yum update
yum upgrade -y

# install jdk
yum install -y java-1.8.0-openjdk

# fix locale warning
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

# add kafka user
useradd kafka -d /opt/kafka

# install kafka 2.13-3.1.0
su -l kafka -c "tar xzvf /vagrant/kafka_2.13-3.1.0.tgz -C /opt/kafka"
su -l kafka -c "ln -s kafka_2.13-3.1.0 kafka"
su -l kafka -c "echo 'export KAFKA_HOME=\$HOME/kafka' >> .bashrc"
su -l kafka -c "echo 'export PATH=\$PATH:\$KAFKA_HOME/bin' >> .bashrc"
su -l kafka -c "zookeeper-server-start.sh -daemon \$KAFKA_HOME/config/zookeeper.properties"
su -l kafka -c "kafka-server-start.sh -daemon \$KAFKA_HOME/config/server.properties"

