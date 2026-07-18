#!/bin/bash


# =====================
# 获取项目根目录
# =====================

BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)



# =====================
# 加载配置文件
# =====================

config_file="$BASE_DIR/config/config.conf"


if [ ! -f "$config_file" ]; then

    echo "配置文件不存在：$config_file"

    exit 1

fi


source "$config_file"



# =====================
# 路径配置
# =====================

backup_dir="$BASE_DIR/$BACKUP_DIR"



# =====================
# 清理旧备份
# =====================

echo "========================="
echo "开始清理旧备份"
echo "保留时间：${KEEP_DAYS}天"
echo "========================="



# =====================
# 删除旧压缩包
# =====================

echo "正在删除 ${KEEP_DAYS} 天前的旧压缩包..."


find "$BASE_DIR" \
    -maxdepth 1 \
    -type f \
    -name "backup_*.tar.gz" \
    -mtime +"$KEEP_DAYS" \
    -print \
    -delete



# =====================
# 删除备份目录中的旧文件
# =====================

echo "正在删除备份目录中的旧文件..."


find "$backup_dir" \
    -type f \
    -mtime +"$KEEP_DAYS" \
    -print \
    -delete



echo "========================="
echo "清理完成！"
echo "========================="
