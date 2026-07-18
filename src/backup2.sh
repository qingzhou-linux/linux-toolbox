#!/bin/bash


# 获取项目根目录
BASE_DIR=$(cd "$(dirname "$0")/.." && pwd)


# 加载配置文件
config_file="$BASE_DIR/config/config.conf"


if [ ! -f "$config_file" ]; then

    echo "配置文件不存在: $config_file"

    exit 1

fi


source "$config_file"


# 生成绝对备份路径
backup_dir="$BASE_DIR/$BACKUP_DIR"


# 创建备份目录
mkdir -p "$backup_dir"


# 获取时间
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


        backup_file="$backup_dir/${filename%.*}_$time.${filename##*.}"


        cp "$file" "$backup_file"


        echo "已备份: $file → $backup_file"


    else


        echo "文件不存在：$file"


    fi

done


echo "全部处理完成"
