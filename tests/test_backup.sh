#!/bin/bash


echo "======================"
echo " Testing backup "
echo "======================"


# 创建测试文件

echo "hello linux toolbox" > test_file.txt


# 执行备份

../src/backup2.sh test_file.txt


# 检查备份目录

if [ -d "../backup" ]; then

    echo "backup directory exists"

else

    echo "backup directory missing"

    exit 1

fi



# 检查备份文件数量

count=$(ls ../backup | wc -l)


if [ $count -gt 0 ]; then

    echo "backup test passed"

else

    echo "backup test failed"

fi



# 删除测试文件

rm test_file.txt
