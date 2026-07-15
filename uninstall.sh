#!/bin/bash


# =====================
# Linux工具箱卸载程序
# =====================


echo "========================="
echo " Linux工具箱卸载程序"
echo "========================="



APP_DIR="/usr/local/share/tool"

BIN_FILE="/usr/local/bin/tool"



# =====================
# 删除命令
# =====================


if [ -f "$BIN_FILE" ]; then

    echo "删除命令：$BIN_FILE"

    sudo rm "$BIN_FILE"

else

    echo "命令不存在：$BIN_FILE"

fi



# =====================
# 删除程序目录
# =====================


if [ -d "$APP_DIR" ]; then

    echo "删除程序目录：$APP_DIR"

    sudo rm -rf "$APP_DIR"

else

    echo "程序目录不存在：$APP_DIR"

fi



echo ""

echo "========================="
echo "卸载完成！"
echo "========================="
