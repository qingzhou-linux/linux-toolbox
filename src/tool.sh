#!/bin/bash


version="1.8"


source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"


tool_load_config || exit 1



info()
{

echo "========================="
echo " Linux工具箱信息"
echo "========================="

echo "版本：$version"

echo "程序目录：$TOOL_ROOT"

echo "配置文件：$TOOL_CONFIG_FILE"

echo "备份目录：$BACKUP_DIR"

echo "日志文件：$LOG_FILE"

echo "========================="

}



status()
{


echo "========================="
echo " Linux工具状态"
echo "========================="


mkdir -p "$BACKUP_DIR"


count=$(ls "$BACKUP_DIR" | wc -l)


echo "备份数量：$count"


latest=$(ls -t "$BACKUP_DIR" 2>/dev/null | head -1)


echo "最新备份：$latest"



size=$(du -sh "$BACKUP_DIR" 2>/dev/null | awk '{print $1}')


echo "备份大小：$size"



if [ -f "$LOG_FILE" ]; then

echo "日志：正常"

else

echo "日志：不存在"

fi


echo "========================="

}




case "$1" in


backup)

shift

log "执行备份:$@"

"$TOOL_BIN_DIR/backup2.sh" "$@"


;;



compress)

"$TOOL_BIN_DIR/backup3.sh"


;;



clean)

"$TOOL_BIN_DIR/clean.sh"


;;



info)

info


;;



status)

status


;;



version)

echo "Linux工具箱版本:$version"


;;



help|"")

echo "tool backup 文件"

echo "tool compress"

echo "tool clean"

echo "tool info"

echo "tool status"

echo "tool version"


;;



*)

echo "未知命令"

;;

esac
