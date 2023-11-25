#!/bin/sh

jupyter-lab --NotebookApp.password=`python -c "from jupyter_server.auth import passwd; print(passwd('$LAB_PASSWORD'))"` --ip='*' --allow-root --no-browser --notebook-dir="/root/notebooks" --NotebookApp.base_url="/$LAB_USER/"
