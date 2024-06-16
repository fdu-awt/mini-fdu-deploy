#!/bin/bash

# 停止旧版本
docker-compose down

# 定义一个包含Docker镜像名称的数组
imageArray=("zmarkgo/mini-fdu-user:1.0.0" "zmarkgo/mini-fdu-study:1.0.0" "zmarkgo/mini-fdu-socket:1.0.0" "zmarkgo/mini-fdu-ai:1.0.0" "zmarkgo/mini-fdu-gateway:1.0.0" "zmarkgo/mini-fdu-front:1.0.0")

# 定义一个包含镜像导出文件名的数组
exportFileArray=("mini-fdu-user-1.0.0" "mini-fdu-study-1.0.0" "mini-fdu-socket-1.0.0" "mini-fdu-ai-1.0.0" "mini-fdu-gateway-1.0.0" "mini-fdu-front-1.0.0")

# 定义导出镜像的目录
exportDir="./images"

# 导入镜像
for ((i=0; i<${#imageArray[@]}; i++)); do
    imageName="${imageArray[$i]}"
    exportFile="${exportDir}/${exportFileArray[$i]}"

    # 检查文件是否存在
    if [ -f "$exportFile" ]; then
        # 加载Docker镜像
        docker rmi $imageName
        docker load -i "$exportFile"
        echo "Import image $imageName from $exportFile"
    else
        echo "Error: File $exportFile does not exist."
    fi
done

# 启动新版本
docker-compose up -d