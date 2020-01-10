# mongodb
在mongodb镜像的基础上，加上定时任务备份数据库的功能。

# 说明
```bash
Dockerfile # docker
crontabfile # 定时任务
run.sh # 执行脚本
mongodb_back.sh # 备份mongodb脚本
```

## 默认
```bash
#定时任务设定为 每日6点执行

# 默认备份的数据库 为yapi，可以通过Dockerfile中指定备份dbname
```