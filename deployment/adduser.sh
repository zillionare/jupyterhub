#!/bin/bash

export user=$1
if [ "$2" = "payed" ]
then
    docker run -d -v /data/course/notebooks/courseware:/home/$user/notebooks/courseware:ro -v /data/course/notebooks/examples:/home/$user/notebooks/examples:ro --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/courselab:0.2
else
    docker run -d -v /data/course/notebooks/examples:/home/$user/notebooks/examples:ro --name course_$user -e user=$user -e password=$user@cH --net=course zillionare/courselab:0.2
fi

# 增加欢迎文档
docker cp ./使用说明.ipynb "course_$user:/home/$user/notebooks"

# add nginx conf
sed "s/aaron/$user/g" user.conf.template > /opt/nginx/conf/users/"$user.conf"
docker restart nginx
