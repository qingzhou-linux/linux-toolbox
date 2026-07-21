#!/bin/bash


echo "======================"
echo " Testing clean "
echo "======================"


# shellcheck disable=SC1091
source "$(dirname "$0")/test_helper.sh"


setup_test_env



backup_dir="$TEST_HOME/linux-toolbox-data/backup"



# 创建旧文件

old_file="$backup_dir/old_backup.txt"

echo "old backup" > "$old_file"


touch -d "10 days ago" "$old_file"



# 创建新文件

new_file="$backup_dir/new_backup.txt"

echo "new backup" > "$new_file"



# 确认文件存在

assert_file_exists "$old_file"

assert_file_exists "$new_file"



# 执行清理

TOOL_CONFIG_FILE="$TOOL_CONFIG_FILE" \
./src/tool.sh clean



assert_success $?



# 检查旧文件删除

if [ -f "$old_file" ]; then

    echo "old file still exists"

    exit 1

fi



# 检查新文件保留

if [ ! -f "$new_file" ]; then

    echo "new file removed"

    exit 1

fi



echo "clean test passed"

