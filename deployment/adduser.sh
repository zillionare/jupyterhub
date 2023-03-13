#!/bin/bash

export user=$1
if [ "$2" = "rw" ]
then 
    docker run -d -v /data/course/notebooks:/home/$user/notebooks --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/course
else
    docker run -d -v /data/course/notebooks:/home/$user/notebooks --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/course
fi

# add nginx conf
sed "s/aaron/$user/g" user.conf.template > /opt/nginx/conf/users/"$user.conf"
docker restart nginx
