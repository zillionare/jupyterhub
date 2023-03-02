# this is an example to show how to start a container

sudo docker run -d -p 31822:22 -p 3180-3184:3180-3184 -v /notebooks:/notebooks --name hub zillionare/jupyterhub
