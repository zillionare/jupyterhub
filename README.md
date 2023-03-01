Docker image for jupyter hub.
# Features
1. Create user from admin control panel, and user's home dir will be created as also. Default password for the user is its user's name. The user can open terminal to change. And a `notebooks` folder will be created under this user's home. The folder name can be set by `-e spawner_notebook_dir`.
2. Pull git repo at 0:00:00 every day. Config repo url by `-e repo`. The destination dir is under /root.
3. Copy notebooks dir from repo to spawned user's notebooks dir, if exists. Use `-e repo_notebook_dir` and `-e spawner_notebook_dir` to set source and destination. You should pass in an absolute path (which should be started with /root).
4. Shipped with vi, sshd, git.


# Secrets
The container will have `root` and `admin` users by default. Use `admin` to create new hub user.

The password of root is root, and password for admin is admin.
# Settings
we have these configurabel things:

**JupyterHub.base_url**
use `-e base_url` to set. Default is `/hub`

**Spawner.notebook_dir**
use `-e spawner_notebook_dir` to set. Default is `~/notebooks`


**Spawner.default_url**
use `-e spawner_default_url` to set, Default is `/lab`

**spawner_timeout**
Kill the idle user session when timeout. set by `-e spawner_timeout`, default is 4 hours

**Source notebook's dir**
use `-e repo_notebook_dir` to tell cron job where to copy initial notebooks for spanwed user.

**repo_url**
use `-e repo_url` to configure where to pull latest notebooks. This usually should be an url start with `https`, instead of `git`

# Network
sshd is listening on 22, jupyterhub is listening on 3180, http_proxy_api is listening on 3181.
