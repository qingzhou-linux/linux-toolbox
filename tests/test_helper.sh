#!/bin/bash


# ===================================
# Linux Toolbox Test Helper
# ===================================


PROJECT_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

TEST_ROOT=$(mktemp -d)


export TEST_ROOT


setup_test_env()
{

    export TEST_HOME="$TEST_ROOT/home"

    mkdir -p "$TEST_HOME"


    export TOOL_CONFIG_FILE="$TEST_ROOT/config.conf"


    cat > "$TOOL_CONFIG_FILE" <<EOF
BACKUP_DIR="\$TEST_HOME/linux-toolbox-data/backup"
KEEP_DAYS=7
LOG_FILE="\$TEST_HOME/linux-toolbox-data/logs/tool.log"
EOF


    mkdir -p "$TEST_HOME/linux-toolbox-data/backup"


}



cleanup_test_env()
{

    rm -rf "$TEST_ROOT"

}



assert_success()
{

    if [ "$1" -ne 0 ]; then

        echo "测试失败"

        exit 1

    fi

}



assert_file_exists()
{

    if [ ! -f "$1" ]; then

        echo "文件不存在:$1"

        exit 1

    fi

}


trap cleanup_test_env EXIT
