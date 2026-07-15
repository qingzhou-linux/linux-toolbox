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
# 参数配置
# =====================

backup_dir="$BACKUP_DIR"


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

tar_file="backup_${time}.tar.gz"



tar -czf "$tar_file" "$backup_dir"



if [ $? -eq 0 ]; then

    echo "===================="
    echo "压缩完成！"
    echo "文件：$tar_file"

else

    echo "压缩失败！"

    exit 1

fi
