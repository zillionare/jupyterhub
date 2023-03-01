#!/bin/sh

/usr/sbin/sshd -D
jupyterhub -f /etc/jupyterhub/jupyterhub_config.py
