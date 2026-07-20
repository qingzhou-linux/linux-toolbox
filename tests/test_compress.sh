#!/bin/bash


echo "======================"
echo " Testing compress "
echo "======================"


source "$(dirname "$0")/test_helper.sh"


setup_test_env



# 使用测试环境中的备份目录

backup_dir="$TEST_HOME/linux-toolbox-data/backup"



mkdir -p "$backup_dir"



# 创建测试备份文件

test_file="$backup_dir/compress_test.txt"


echo "compress test data" > "$test_file"



assert_file_exists "$test_file"



echo "执行压缩..."



# 使用隔离 HOME

HOME="$TEST_HOME" \
TOOL_CONFIG_FILE="$TOOL_CONFIG_FILE" \
./src/tool.sh compress



assert_success $?



# 查找压缩包

tar_file=$(find "$TEST_HOME/linux-toolbox-data" \
-name "backup_*.tar.gz" \
-type f \
| head -1)



if [ -z "$tar_file" ]; then

    echo "compress file missing"

    exit 1

fi



echo "compress file exists:"
echo "$tar_file"



echo "检查压缩内容..."



tar_content=$(tar -tzf "$tar_file")



echo "$tar_content"



echo "$tar_content" | grep -q "compress_test.txt"



if [ $? -ne 0 ]; then

    echo "compress content check failed"

    exit 1

fi



echo "compress test passed"
