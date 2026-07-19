#!/bin/bash


echo "======================"
echo " Testing clean "
echo "======================"


# 创建测试文件

test_file="../backup/old_backup.txt"


echo "old backup test" > "$test_file"



# 修改时间为10天以前

touch -d "10 days ago" "$test_file"



# 确认文件存在

if [ ! -f "$test_file" ]; then

    echo "create test file failed"

    exit 1

fi



# 执行清理

../src/clean.sh



# 检查文件是否被删除

if [ -f "$test_file" ]; then

    echo "clean test failed"

    exit 1

else

    echo "clean test passed"

fi
