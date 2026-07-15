#!/bin/bash

BASE_DIR=$(cd "$(dirname "$0")" && pwd)


if [ -f "$BASE_DIR/../config/config.conf" ]; then

    config_file="$BASE_DIR/../config/config.conf"


elif [ -f "$BASE_DIR/config.conf" ]; then

    config_file="$BASE_DIR/config.conf"


else

    echo "配置文件不存在"

    exit 1

fi


source "$config_file"
backup_dir=$BACKUP_DIR
mkdir -p $backup_dir

time=$(date +%Y%m%d_%H%M%S)

# 没有参数
   if [ $# -eq 0 ]; then
    echo "用法：./backup2.sh 文件1 文件2 ..."
    exit 1
fi

# 遍历所有参数
for file in "$@"
do
   if [ -f "$file" ]; then
       filename=$(basename "$file")

backup_file=$backup_dir/${filename%.*}_$time.${filename##*.}
       cp "$file" "$backup_file"
       echo "已备份: $file → $backup_file"

   else
       echo "文件不存在：$file"
   fi
done

echo "全部处理完成"
