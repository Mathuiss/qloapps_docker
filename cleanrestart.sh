#! /bin/bash

sudo docker rm -f hoteldemo
sudo docker rmi -f hoteldemo-dist
sudo docker build -t hoteldemo-dist .
# sudo docker run -d --name hoteldemo -p 8080:80 -v /home/mathuis/Downloads/actionlistdb:/var/lib/mysql hoteldemo-dist
sudo docker run -d --name hoteldemo -p 8080:80 hoteldemo-dist
sudo docker logs -f hoteldemo