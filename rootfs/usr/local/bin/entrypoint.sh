#!/bin/sh

/usr/sbin/sshd
jupyterhub -f /etc/jupyterhub/config.py
