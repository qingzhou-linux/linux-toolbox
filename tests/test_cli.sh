#!/bin/bash


echo "======================"
echo " Testing CLI "
echo "======================"


source "$(dirname "$0")/test_helper.sh"


setup_test_env



# 测试 help

echo "Testing help..."


output=$(TOOL_CONFIG_FILE="$TOOL_CONFIG_FILE" \
./src/tool.sh help)



echo "$output"


echo "$output" | grep -q "tool backup"


if [ $? -ne 0 ]; then

    echo "help test failed"

    exit 1

fi



echo "help test passed"



# 测试 version

echo "Testing version..."


output=$(TOOL_CONFIG_FILE="$TOOL_CONFIG_FILE" \
./src/tool.sh version)



echo "$output"



echo "$output" | grep -q "1.8"


if [ $? -ne 0 ]; then

    echo "version test failed"

    exit 1

fi


echo "version test passed"



# 测试未知命令

echo "Testing unknown command..."


output=$(TOOL_CONFIG_FILE="$TOOL_CONFIG_FILE" \
./src/tool.sh abc)



echo "$output"



echo "$output" | grep -q "未知命令"



if [ $? -ne 0 ]; then

    echo "unknown command test failed"

    exit 1

fi


echo "unknown command test passed"



echo "CLI test passed"
