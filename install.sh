#!/bin/bash


# =====================
# Linux工具箱安装程序
# =====================


echo "========================="
echo " Linux工具箱安装程序"
echo "========================="



# 获取当前项目路径

BASE_DIR=$(cd "$(dirname "$0")" && pwd)



APP_DIR="/usr/local/share/tool"

BIN_DIR="/usr/local/bin"



# =====================
# 检查文件
# =====================

check_file()
{

    if [ ! -f "$1" ]; then

        echo "错误：找不到文件 $1"

        exit 1

    fi

}



echo "检查安装文件..."



check_file "$BASE_DIR/src/tool.sh"

check_file "$BASE_DIR/src/backup2.sh"

check_file "$BASE_DIR/src/backup3.sh"

check_file "$BASE_DIR/src/clean.sh"

check_file "$BASE_DIR/config/config.conf"



echo "文件检查完成"



# =====================
# 创建目录
# =====================


echo "创建安装目录..."

sudo mkdir -p "$APP_DIR"



# =====================
# 复制功能模块
# =====================


echo "复制功能模块..."

sudo cp "$BASE_DIR/src/backup2.sh" "$APP_DIR/"

sudo cp "$BASE_DIR/src/backup3.sh" "$APP_DIR/"

sudo cp "$BASE_DIR/src/clean.sh" "$APP_DIR/"



# =====================
# 复制配置
# =====================


echo "复制配置文件..."

sudo cp "$BASE_DIR/config/config.conf" "$APP_DIR/"



# =====================
# 安装命令
# =====================


echo "安装主命令..."

sudo cp "$BASE_DIR/src/tool.sh" "$BIN_DIR/tool"



# =====================
# 设置权限
# =====================


echo "设置权限..."

sudo chmod +x "$BIN_DIR/tool"

sudo chmod +x "$APP_DIR"/*.sh



# =====================
# 完成
# =====================


echo "========================="
echo "安装完成！"
echo "========================="


echo ""

echo "测试命令："

echo "  tool help"

echo "  tool version"

echo "  tool status"
