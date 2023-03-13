#!/bin/bash

docker network create course

docker run -d --name nginx -p 5280:80 -v /opt/nginx/conf:/etc/nginx -v /data/site:/var/html/www --net=course nginx:latest
