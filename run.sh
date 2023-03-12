# this is an example to show how to start a container

sudo docker run -d -p 31822:22 -p 3180-3184:3180-3184 -v /notebooks:/notebooks --name course cheese_course

# docker run -d -p 5122:22 -p 5180-5184:3180-3184 -v /data/course/notebooks:/notebooks --name course zillionare/cheese_course:0.1

