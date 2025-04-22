#!/bin/bash

# 切换到 docker/ 目录
cd "$(dirname "$0")/docker" || exit 1

# 设置镜像名称
LOCAL_IMAGE="modernwms:latest"
REMOTE_IMAGE="registry.cn-chengdu.aliyuncs.com/yaotutu/wms:latest"

echo "📦 开始构建镜像: $LOCAL_IMAGE"
sudo docker build -t $LOCAL_IMAGE .

if [ $? -ne 0 ]; then
  echo "❌ 构建失败，退出脚本"
  exit 1
fi

echo "🏷️ 打标签为远程镜像: $REMOTE_IMAGE"
sudo docker tag $LOCAL_IMAGE $REMOTE_IMAGE

echo "📤 推送镜像到阿里云..."
sudo docker push $REMOTE_IMAGE

echo "✅ 镜像推送完成！"