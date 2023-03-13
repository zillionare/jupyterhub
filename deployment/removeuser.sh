read -r -n1 -p "将删除course_$1的容器，请确认？[y/Y]" response
response=${response,,}
if [ "$response" = "y" ]; then
    docker rm -f course_$1
    rm /opt/nginx/conf/users/$1.conf
    docker restart nginx
fi
