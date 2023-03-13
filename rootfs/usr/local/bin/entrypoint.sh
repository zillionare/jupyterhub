#!/bin/sh

jupyter notebook --NotebookApp.password=`python -c "from notebook.auth import passwd; print(passwd('$password'))"` --ip='*' --allow-root --no-browser --notebook-dir="/home/$user/notebooks" --NotebookApp.base_url="/$user"
