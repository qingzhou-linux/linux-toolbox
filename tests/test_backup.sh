#!/bin/bash


echo "======================"
echo " Testing backup "
echo "======================"


# 加载测试环境

source "$(dirname "$0")/test_helper.sh"


setup_test_env



# 创建测试文件

test_file="$TEST_HOME/test_file.txt"

echo "hello linux toolbox" > "$test_file"



# 执行备份

TOOL_CONFIG_FILE="$TOOL_CONFIG_FILE" \
./src/tool.sh backup "$test_file"



assert_success $?



# 查找备份文件

backup_file=$(find "$TEST_HOME/linux-toolbox-data/backup" \
-name "test_file_*.txt" \
-type f)



if [ -n "$backup_file" ]; then

    echo "backup file exists"

else

    echo "backup test failed"

    exit 1

fi



echo "backup test passed"
