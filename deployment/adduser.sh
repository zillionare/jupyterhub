#!/bin/bash

export user=$1
if [ "$2" = "rw" ]
then 
    docker run -d -v /data/course/notebooks/courseware:/home/$user/notebooks/courseware -v /data/course/notebooks/examples:/home/$user/notebooks/examples --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/courselab
else
    docker run -d -v /data/course/notebooks/courseware:/home/$user/notebooks/courseware:ro -v /data/course/notebooks/examples:/home/$user/notebooks/examples:ro --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/courselab
fi

# add nginx conf
sed "s/aaron/$user/g" user.conf.template > /opt/nginx/conf/users/"$user.conf"
docker restart nginx
