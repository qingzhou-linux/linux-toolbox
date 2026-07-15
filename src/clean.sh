#!/bin/bash


# =====================
# 获取脚本路径
# =====================

BASE_DIR=$(cd "$(dirname "$0")" && pwd)


# =====================
# 加载配置文件
# =====================

if [ -f "$BASE_DIR/../config/config.conf" ]; then

    config_file="$BASE_DIR/../config/config.conf"

elif [ -f "$BASE_DIR/config.conf" ]; then

    config_file="$BASE_DIR/config.conf"

else

    echo "配置文件不存在"
    exit 1

fi


source "$config_file"


# =====================
# 清理旧备份
# =====================

echo "========================="
echo "开始清理旧备份"
echo "保留时间：${KEEP_DAYS}天"
echo "========================="


# 删除旧压缩包

echo "正在删除 ${KEEP_DAYS} 天前的旧压缩包..."

find "$BASE_DIR/.." \
    -maxdepth 1 \
    -type f \
    -name "backup_*.tar.gz" \
    -mtime +"$KEEP_DAYS" \
    -print \
    -delete


# 删除备份目录中的旧文件

echo "正在删除备份目录中的旧文件..."

find "$BACKUP_DIR" \
    -type f \
    -mtime +"$KEEP_DAYS" \
    -print \
    -delete


echo "========================="
echo "清理完成！"
echo "========================="
