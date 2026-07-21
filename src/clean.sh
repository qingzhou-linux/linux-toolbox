#!/bin/bash


# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"



tool_load_config || exit 1



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
