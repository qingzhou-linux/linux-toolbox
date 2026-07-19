#!/bin/bash


# =====================
# Linux工具箱安装程序
# =====================


echo "========================="
echo " Linux工具箱安装程序"
echo "========================="



# 项目根目录

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
# 创建安装目录
# =====================


echo "创建安装目录..."

sudo mkdir -p "$APP_DIR"



# =====================
# 复制程序文件
# =====================


echo "复制程序文件..."


sudo cp "$BASE_DIR/src/tool.sh" "$APP_DIR/"

sudo cp "$BASE_DIR/src/backup2.sh" "$APP_DIR/"

sudo cp "$BASE_DIR/src/backup3.sh" "$APP_DIR/"

sudo cp "$BASE_DIR/src/clean.sh" "$APP_DIR/"



# =====================
# 复制配置文件
# =====================


echo "复制配置文件..."


sudo cp "$BASE_DIR/config/config.conf" "$APP_DIR/config.conf"



# =====================
# 创建命令入口
# =====================


echo "创建tool命令..."


sudo bash -c "cat > $BIN_DIR/tool" <<EOF
#!/bin/bash

/usr/local/share/tool/tool.sh "\$@"
EOF



# =====================
# 权限
# =====================


echo "设置权限..."


sudo chmod +x "$BIN_DIR/tool"

sudo chmod +x "$APP_DIR"/*.sh



echo "========================="
echo "安装完成！"
echo "========================="


echo ""

echo "测试命令："

echo "  tool help"

echo "  tool version"

echo "  tool info"

echo "  tool status"
