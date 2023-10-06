#! /bin/bash

sudo docker rm -f $(sudo docker ps -aq)
sudo docker rmi -f hotel-img
sudo docker build -t hotel-img .
sudo docker-compose up