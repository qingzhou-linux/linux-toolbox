#!/bin/bash

# Linux Toolbox shared path, configuration, and logging helpers.
# Sourcing this file has no side effects; callers explicitly invoke the
# function they need.

tool_resolve_paths()
{
    local common_dir
    local parent_dir
    local default_config_file

    common_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
    parent_dir=$(cd "$common_dir/.." && pwd)

    if [ "$(basename "$parent_dir")" = "src" ]; then
        # Source tree: <project>/src/lib/common.sh
        TOOL_ROOT=$(cd "$parent_dir/.." && pwd)
        TOOL_BIN_DIR="$TOOL_ROOT/src"
        TOOL_ENVIRONMENT="source"
        default_config_file="$TOOL_ROOT/config/config.conf"
    else
        # Installed tree: /usr/local/share/tool/lib/common.sh
        TOOL_ROOT="$parent_dir"
        TOOL_BIN_DIR="$TOOL_ROOT"
        TOOL_ENVIRONMENT="installed"
        default_config_file="$TOOL_ROOT/config.conf"
    fi

    if [ -z "${TOOL_CONFIG_FILE:-}" ]; then
        TOOL_CONFIG_FILE="$default_config_file"
    fi
}


tool_load_config()
{
    tool_resolve_paths || return 1

    if [ ! -f "$TOOL_CONFIG_FILE" ]; then
        echo "配置文件不存在:$TOOL_CONFIG_FILE"
        return 1
    fi

    # The existing project configuration is a trusted Bash configuration file.
    # shellcheck source=/dev/null
    source "$TOOL_CONFIG_FILE"
}


tool_log()
{
    if [ -z "${LOG_FILE:-}" ]; then
        echo "日志文件未配置"
        return 1
    fi

    mkdir -p "$(dirname "$LOG_FILE")" || return 1
    echo "$(date '+%Y-%m-%d %H:%M:%S') $*" >> "$LOG_FILE"
}


# Backward-compatible name used by the existing CLI script.
log()
{
    tool_log "$@"
}
