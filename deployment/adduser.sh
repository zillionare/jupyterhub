#!/bin/bash

set -o errexit

export user=$1
passwd=`echo -n $name | md5sum`
passwd="${user:0:3}@${passwd:4:2}${passwd:12:2}${passwd:8:2}"


echo "创建用户环境中，大约需要10秒钟左右..."
if [ "$2" = "payed" ]
then
    docker run -d -v /data/course/notebooks/courseware:/root/notebooks/courseware:ro -v /data/course/notebooks/examples:/root/notebooks/examples:ro --name course_$user -e LAB_USER=$user -e LAB_PASSWORD=$passwd --net=course zillionare/lab
else
    docker run -d -v /data/course/notebooks/examples:/root/notebooks/examples:ro --name course_$user -e LAB_USER=$user -e LAB_PASSWORD=$passwd --net=course zillionare/lab
fi

echo "用户环境创建成功，配置中..."
# 增加欢迎文档
docker cp ./使用说明.ipynb "course_$user:/root/notebooks"
./update_software.sh $user
./update_exercise.sh $user

# add nginx conf
sed "s/aaron/$user/g" user.conf.template > /opt/nginx/conf/users/"$user.conf"
docker exec nginx nginx -s reload

echo $user >> names.txt
echo "已成功为用户创建环境，请保存以下信息"
echo "-------------"
echo "用户：$user"
echo "密码：$passwd"
echo "网址：http://139.196.218.124:5180/$user/login"
echo "`date` $user $passwd" >> ./users.txt
