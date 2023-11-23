# 部署

首先通过network.sh创建网络及nginx容器。需要事先将deployment/nginx目录下的文件拷贝到/opt/nginx/conf。
增加新用户通过adduser.sh来完成。$1参数是用户名，$2为是否给予写权限。如果要提供写权限，请输入rw，其它（含不提供）都为只读。

## 环境变量

```
REDIS_HOST
REDIS_PORT
INFLUXDB_URL
INFLUXDB_TOKEN
INFLUXDB_ORG
INFLUXDB_BUCKET
BACKTEST_HOST
BACKTEST_PORT
BACKTEST_VERSION
LAB_PASSWORD
```
