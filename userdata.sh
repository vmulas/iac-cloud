#!/bin/bash -v
#apt-get update -y
#apt-get install -y nginx > /tmp/nginx.log
apt-get install -y python && \
sudo apt-get update && \
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' && \
sudo apt-get update && \
sudo apt-get install -y docker-engine


