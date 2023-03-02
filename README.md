Docker image for jupyter hub.
# Features
1. Create User from admin panel. New user's password is as same as username.
2. Sync host's notebook files to spawner's notebook_dir.
3. Shipped with vi, sshd, git.
4. Added talib and zillionare-omicron, configured. This is a private version.
5. Each user will use ~/cheese/config as configure dir and /var/log/`user`/cheese.log as log file

# Usage
## Create New User
First, login with user `admin`. 

![](https://images.jieyu.ai/images/2023/03/20230301235135.png)

Then navigate to "Hub Control Panel":

![](https://images.jieyu.ai/images/2023/03/20230301235234.png)

Then click on "Admin" tab, you can now create new users here:

![](https://images.jieyu.ai/images/2023/03/20230301235321.png)

Once the new user is created, please click on "Spawn Page" button, this will set password for the new created user.

!!! Important
    Password for new user is as same as its username. Please ask him to change password ASAP.

Now the new user can login using his username and password.

# Secrets
The container will have `root` and `admin` users by default. Use `admin` to create new hub user.

The password of root is root, and password for admin is admin.
# Settings
we have these configurabel things:

**JupyterHub.base_url**
use `-e base_url` to set. Default is `/`

**Spawner.notebook_dir**
use `-e spawner_notebook_dir` to set. Default is `~/notebooks`


**Spawner.default_url**
use `-e spawner_default_url` to set, Default is `/lab`

**spawner_timeout**
Kill the idle user session when timeout. set by `-e spawner_timeout`, default is 4 hours

**volume mapping**
use `-v host_notebooks_volume:/notebooks` to map host notebooks dir to container. When new user is created, these notebooks will be copied into his notebooks dir, specified by `spwaner_notebook_dir`.

!!! Important
    The copy happend only once for each user. It happends when user first login.

# Network
sshd is listening on 22, jupyterhub is listening on 3180, http_proxy_api is listening on 3181.
