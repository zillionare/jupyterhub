
import os

base_url = os.environ.get('base_url', '/hub')

spawner_notebook_dir  = os.environ.get('spawner_notebook_dir', '~/notebooks')
spawner_default_url = os.environ.get('spawner_default_url', '/lab')
spawner_timeout = os.environ.get('spawner_timeout', 14400)

c.ConfigurableHTTPProxy.api_url = 'http://127.0.0.1:3181'
 
# 对外登录设置的ip
c.JupyterHub.ip = '0.0.0.0'
c.JupyterHub.base_url = base_url
c.JupyterHub.port = 3180
c.PAMAuthenticator.encoding = 'utf8'
 
c.Authenticator.admin_users = {'admin'}
c.JupyterHub.admin_access = True 
c.LocalAuthenticator.create_system_users=True
 
# 设置每个用户的 book类型 和 工作目录（创建.ipynb文件自动保存的地方）
c.Spawner.notebook_dir = spawner_notebook_dir
c.Spawner.default_url = spawner_default_url
 
# 为jupyterhub 添加额外服务，用于处理闲置用户进程。使用时不好使安装一下：pip install jupyterhub-ilde-culler
c.JupyterHub.services = [
    {
        'name': 'idle-culler',
        'command': ['python', '-m', 'jupyterhub_idle_culler', f'--timeout={spawner_timeout}'],
        'admin':True # 1.5.0 需要服务管理员权限，去kill 部分闲置的进程notebook, 2.0版本已经改了，可以只赋给 idel-culler 部分特定权限，roles
    }
]

import distutils
# hooks
import os
import subprocess
from distutils.dir_util import copy_tree
from pwd import getpwnam


def set_passwd(username:str, password:str):
    p = subprocess.Popen([ "/usr/sbin/chpasswd" ], universal_newlines=True, shell=False, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (stdout, stderr) = p.communicate(username + ":" + password + "\n")
    assert p.wait() == 0
    if stdout or stderr:
        raise Exception("Error encountered changing the password!")
    
def create_dir_hook(spawner):
    username = spawner.user.name

    user_spec_dir = os.environ.get("spawner_notebook_dir", 'notebooks')

    dst_dir = os.path.join("/home", username, user_spec_dir)

    src_dir = '/notebooks'
    os.makedirs(dst_dir, exist_ok = True)
    try:
        copy_tree(src_dir, dst_dir)
    except distutils.errors.DistutilsFileError:
        pass

    gid = getpwnam(username).pw_gid
    uid = getpwnam(username).pw_uid
    os.chown(dst_dir, uid, gid)

    set_passwd(username, username)

c.Spawner.pre_spawn_hook = create_dir_hook
