#!/bin/bash


version="1.2"


# =====================
# 获取程序路径
# =====================

BASE_DIR=$(cd "$(dirname "$0")" && pwd)



# =====================
# 加载配置文件
# =====================

if [ -f "$BASE_DIR/../config/config.conf" ]; then

    config_file="$BASE_DIR/../config/config.conf"


elif [ -f "/usr/local/share/tool/config.conf" ]; then

    config_file="/usr/local/share/tool/config.conf"


else

    echo "配置文件不存在"

    exit 1

fi


# 加载配置
source "$config_file"



# 日志文件
log_file="$LOG_FILE"



# =====================
# 日志函数
# =====================

log()
{
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" >> "$log_file"
}



# =====================
# 帮助
# =====================

help()
{

echo "========================="

echo " Linux工具箱 v$version"

echo "========================="

echo ""

echo "用法:"

echo ""

echo " tool backup 文件1 文件2..."

echo "      备份指定文件"

echo ""

echo " tool compress"

echo "      压缩备份"

echo ""

echo " tool clean"

echo "      清理旧备份"

echo ""

echo " tool status"

echo "      查看状态"

echo ""

echo " tool info"

echo "      软件信息"

echo ""

echo " tool version"

echo "      查看版本"

}



# =====================
# 软件信息
# =====================

info()
{

echo "========================="

echo " Linux工具箱信息"

echo "========================="


echo "版本：$version"


echo "程序目录：$BASE_DIR"


echo "配置文件：$config_file"


echo "备份目录：$BACKUP_DIR"


echo "日志文件：$log_file"


echo "========================="

}



# =====================
# 状态查看
# =====================

status()
{


echo "========================="

echo " Linux工具状态"

echo "========================="



if [ -d "$BACKUP_DIR" ]; then


count=$(ls "$BACKUP_DIR" | wc -l)


echo "备份数量：$count"



latest=$(ls -t "$BACKUP_DIR" | head -1)



if [ -n "$latest" ]; then

echo "最新备份：$latest"

else

echo "最新备份：暂无"

fi



size=$(du -sh "$BACKUP_DIR" | awk '{print $1}')

echo "备份大小：$size"



else


echo "备份目录不存在"


fi



if [ -f "$log_file" ]; then

echo "日志：正常"

else

echo "日志：不存在"

fi



echo "========================="

}



# =====================
# 检查文件
# =====================

check_script()
{

if [ ! -f "$1" ]; then

echo "错误：找不到 $1"

exit 1

fi

}



# =====================
# 主命令
# =====================

case $1 in
info)

echo "======================"
echo " Linux Toolbox "
echo "======================"

echo "Version: 1.5"
echo "Backup Dir: $BACKUP_DIR"
echo "Log File: $LOG_FILE"

echo "======================"

;;


backup)

shift


if [ $# -eq 0 ]; then

echo "请输入文件"

exit 1

fi


check_script "/usr/local/share/tool/backup2.sh"


log "执行备份:$@"


/usr/local/share/tool/backup2.sh "$@"


;;



compress)


check_script "/usr/local/share/tool/backup3.sh"


log "执行压缩"


/usr/local/share/tool/backup3.sh


;;



clean)


check_script "/usr/local/share/tool/clean.sh"


log "执行清理"


/usr/local/share/tool/clean.sh


;;



status)

status

;;



info)

info

;;



version)

echo "Linux工具箱版本:$version"

;;



help|"")

help

;;



*)

echo "未知命令:$1"

help

;;

esac
