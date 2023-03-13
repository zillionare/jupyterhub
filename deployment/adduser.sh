#!/bin/bash

export user=$1
if [ "$2" = "rw" ]
then 
    docker run -d -v /data/course/notebooks/courseware:/home/$user/notebooks/courseware -v /data/course/notebooks/examples:/home/$user/notebooks/examples --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/courselab
else
    docker run -d -v /data/course/notebooks/courseware:/home/$user/notebooks/courseware:ro -v /data/course/notebooks/examples:/home/$user/notebooks/examples:ro --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/courselab
fi

# 增加欢迎文档
docker cp ./欢迎使用大富翁量化环境.ipynb "course_$user:/home/$user/notebooks"

# add nginx conf
sed "s/aaron/$user/g" user.conf.template > /opt/nginx/conf/users/"$user.conf"
docker restart nginx
