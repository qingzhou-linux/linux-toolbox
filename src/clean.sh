#!/bin/bash


# =====================
# 获取程序目录
# =====================

CURRENT_DIR=$(cd "$(dirname "$0")" && pwd)



# =====================
# 加载配置
# =====================


if [ -f "$CURRENT_DIR/../config/config.conf" ]; then

    # 源码运行

    config_file="$CURRENT_DIR/../config/config.conf"



elif [ -f "/usr/local/share/tool/config.conf" ]; then

    # 安装运行

    config_file="/usr/local/share/tool/config.conf"



else

    echo "配置文件不存在: $config_file"

    exit 1

fi



source "$config_file"



# =====================
# 开始清理
# =====================


echo "========================="
echo "开始清理旧备份"
echo "保留时间：${KEEP_DAYS}天"
echo "========================="



# =====================
# 删除旧压缩包
# =====================


echo "正在删除旧压缩包..."

find "$HOME/linux-toolbox-data" \
-type f \
-name "backup_*.tar.gz" \
-mtime +"$KEEP_DAYS" \
-print \
-delete



# =====================
# 删除旧备份文件
# =====================


echo "正在删除备份目录中的旧文件..."

find "$BACKUP_DIR" \
-type f \
-mtime +"$KEEP_DAYS" \
-print \
-delete



echo "========================="
echo "清理完成！"
echo "========================="
