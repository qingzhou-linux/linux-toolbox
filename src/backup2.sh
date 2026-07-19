#!/bin/bash


source /usr/local/share/tool/config.conf


mkdir -p "$BACKUP_DIR"


time=$(date +%Y%m%d_%H%M%S)



if [ $# -eq 0 ]; then

echo "请输入文件"

exit 1

fi



for file in "$@"
do

if [ -f "$file" ]; then


filename=$(basename "$file")


backup_file="$BACKUP_DIR/${filename%.*}_$time.${filename##*.}"


cp "$file" "$backup_file"


echo "已备份: $file -> $backup_file"


else

echo "文件不存在:$file"


fi

done
