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
# 参数配置
# =====================

backup_dir="$BASE_DIR/$BACKUP_DIR"


time=$(date +%Y%m%d_%H%M%S)



# =====================
# 检查备份目录
# =====================

if [ ! -d "$backup_dir" ]; then

    echo "备份目录不存在：$backup_dir"

    exit 1

fi



# =====================
# 压缩
# =====================


tar_file="$BASE_DIR/backup_${time}.tar.gz"



tar -czf "$tar_file" "$backup_dir"



if [ $? -eq 0 ]; then

    echo "===================="
    echo "压缩完成！"
    echo "文件：$tar_file"
    echo "===================="

else

    echo "压缩失败！"

    exit 1

fi
