#!/bin/bash


# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"



tool_load_config || exit 1



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



if [[ "$backup_dir" = /* ]]; then

tar -czf "$tar_file" -C / "${backup_dir#/}"

else

tar -czf "$tar_file" "$backup_dir"

fi



if [ $? -eq 0 ]; then


echo "====================="
echo "压缩完成！"
echo "文件：$tar_file"
echo "====================="



else


echo "压缩失败！"

exit 1


fi
