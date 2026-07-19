#!/bin/bash


# =====================
# 获取程序目录
# =====================

CURRENT_DIR=$(cd "$(dirname "$0")" && pwd)



# =====================
# 加载配置文件
# =====================


if [ -f "$CURRENT_DIR/../config/config.conf" ]; then

    # 源码环境

    config_file="$CURRENT_DIR/../config/config.conf"



elif [ -f "/usr/local/share/tool/config.conf" ]; then

    # 安装环境

    config_file="/usr/local/share/tool/config.conf"



else

    echo "配置文件不存在: $CURRENT_DIR/../config/config.conf"

    exit 1

fi



source "$config_file"



# =====================
# 参数
# =====================


backup_dir="$BACKUP_DIR"



# =====================
# 检查备份目录
# =====================


if [ ! -d "$backup_dir" ]; then

    echo "备份目录不存在：$backup_dir"

    exit 1

fi



# =====================
# 创建压缩包
# =====================


time=$(date +%Y%m%d_%H%M%S)



tar_file="$HOME/linux-toolbox-data/backup_${time}.tar.gz"



tar -czf "$tar_file" "$backup_dir"



if [ $? -eq 0 ]; then


echo "====================="
echo "压缩完成！"
echo "文件：$tar_file"
echo "====================="



else


echo "压缩失败！"

exit 1


fi
