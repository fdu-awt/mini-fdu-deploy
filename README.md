# mini-fdu-deploy

2024年春季学期《高级Web技术》课程PJ项目部署

## 镜像导出

```powershell
./ExportDockerImages.ps1
```

## 镜像导入

```powershell
./ImportDockerImages.ps1
```

或者shell

```Shell
chmod +x ImportDockerImages.sh
./ImportDockerImages.sh
```

## MySQL 部署

使用docker-compose部署mysql

启动 MySQL-Docker，会使用sh脚本，如果启动失败，可以通过vscode修改 转换换行符：

- 打开[脚本文件](./mini-fdu-mysql/wait-for-it.sh)。
- 点击底部的换行符显示选项，并选择 "CRLF"（Windows）。
- 选择 "LF"（Unix）。

```Shell
cd mini-fdu-mysql
# 启动mysql
docker-compose up -d
# 关闭
docker-compose down
# 关闭：并且删除数据卷
docker-compose down -v
```

## 服务部署

使用本地镜像

```Shell
# 确保位于项目根目录
cd ..
# 启动服务
docker-compose -f docker-compose-local.yml up -d
# 关闭服务
docker-compose -f docker-compose-local.yml down
```

使用远程镜像

```Shell
# 确保位于项目根目录
cd ..
# 启动服务
docker-compose up -d
# 关闭服务
docker-compose down
```
