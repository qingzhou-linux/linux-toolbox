#!/bin/bash


echo "======================"
echo " Testing tool info "
echo "======================"


# shellcheck disable=SC1091
source "$(dirname "$0")/test_helper.sh"


setup_test_env



output=$(TOOL_CONFIG_FILE="$TOOL_CONFIG_FILE" \
./src/tool.sh info)



if [ $? -ne 0 ]; then

    echo "info command failed"

    exit 1

fi



echo "$output"



echo "$output" | grep -q "版本"

if [ $? -ne 0 ]; then

    echo "version information missing"

    exit 1

fi



echo "$output" | grep -q "配置文件"

if [ $? -ne 0 ]; then

    echo "config information missing"

    exit 1

fi



echo "$output" | grep -q "备份目录"

if [ $? -ne 0 ]; then

    echo "backup directory missing"

    exit 1

fi



echo "info test passed"
