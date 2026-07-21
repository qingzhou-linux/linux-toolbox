# Linux Toolbox

Linux Toolbox 是一个使用 Bash 开发的 Linux 文件备份管理工具，提供文件备份、备份目录压缩、历史清理、状态查看和日志记录等功能。

项目既可以直接从源码目录运行，也可以安装为系统命令 `tool`。当前 `develop` 分支处于 v1.9.0-beta 完善阶段，命令行程序报告的版本号仍为 `1.8`。

## 功能列表

- 备份单个或多个普通文件
- 为备份文件添加时间戳
- 将备份目录压缩为 `tar.gz` 文件
- 按配置的保留天数清理历史备份和压缩包
- 查看备份数量、最新备份、备份目录大小和日志状态
- 查看程序目录、配置文件、备份目录和日志文件位置
- 记录备份命令日志
- 支持源码环境和安装环境的统一路径解析
- 支持通过 `TOOL_CONFIG_FILE` 指定配置文件
- 支持安装为 `/usr/local/bin/tool`
- 提供自动化测试、Bash 语法检查、ShellCheck 和 GitHub Actions CI

## 项目结构

```text
linux-toolbox/
├── .github/
│   └── workflows/
│       └── test.yml          # GitHub Actions CI
├── backup/                   # 仓库内占位目录
├── config/
│   └── config.conf           # 默认配置
├── logs/                     # 仓库内占位目录
├── src/
│   ├── lib/
│   │   └── common.sh         # 路径、配置和日志公共模块
│   ├── tool.sh               # CLI 入口与命令分发
│   ├── backup2.sh            # 文件备份
│   ├── backup3.sh            # 备份压缩
│   └── clean.sh              # 历史备份清理
├── tests/
│   ├── check_code.sh         # Bash 语法和 ShellCheck 检查
│   ├── run_test.sh           # 测试入口
│   ├── test_helper.sh        # 隔离测试环境与断言函数
│   ├── test_info.sh
│   ├── test_backup.sh
│   ├── test_clean.sh
│   ├── test_compress.sh
│   └── test_cli.sh
├── install.sh                # 安装脚本
├── uninstall.sh              # 卸载脚本
└── README.md
```

## 安装方法

Linux Toolbox 面向具备 Bash、GNU Coreutils、`find` 和 `tar` 的 Linux 环境。

进入项目目录并执行安装：

```bash
cd linux-toolbox
sudo ./install.sh
```

安装脚本会创建：

```text
/usr/local/bin/tool
/usr/local/share/tool/
├── tool.sh
├── backup2.sh
├── backup3.sh
├── clean.sh
├── config.conf
└── lib/
    └── common.sh
```

安装完成后可以直接运行：

```bash
tool help
```

卸载程序和系统命令：

```bash
sudo ./uninstall.sh
```

卸载脚本不会删除用户目录下的备份、压缩包和日志数据。

## 使用示例

### 查看帮助

```bash
tool help
```

不带参数运行 `tool` 也会显示帮助：

```bash
tool
```

### 查看版本

```bash
tool version
```

当前输出：

```text
Linux工具箱版本:1.8
```

### 查看工具信息

```bash
tool info
```

该命令显示软件版本、程序目录、配置文件、备份目录和日志文件位置。

### 备份文件

备份单个文件：

```bash
tool backup test.txt
```

备份多个文件：

```bash
tool backup file1.txt file2.txt
```

默认备份目录：

```text
$HOME/linux-toolbox-data/backup
```

备份文件使用时间戳命名。例如：

```text
test_20260721_143327.txt
```

当前备份命令只处理普通文件，不递归备份目录。

### 压缩备份

```bash
tool compress
```

压缩包生成在：

```text
$HOME/linux-toolbox-data/backup_YYYYMMDD_HHMMSS.tar.gz
```

执行压缩前，配置的备份目录必须存在。

### 清理历史备份

```bash
tool clean
```

该命令使用 `KEEP_DAYS` 清理：

- `$HOME/linux-toolbox-data` 下超过保留时间的 `backup_*.tar.gz`
- `BACKUP_DIR` 下超过保留时间的普通文件

### 查看状态

```bash
tool status
```

状态信息包括：

- 当前备份数量
- 最新备份文件
- 备份目录大小
- 日志文件是否存在

### 从源码运行

无需安装即可从项目根目录运行：

```bash
./src/tool.sh help
./src/tool.sh info
./src/tool.sh status
```

## 配置说明

默认配置文件为：

- 源码环境：`config/config.conf`
- 安装环境：`/usr/local/share/tool/config.conf`

默认内容：

```bash
BACKUP_DIR="$HOME/linux-toolbox-data/backup"

KEEP_DAYS=7

LOG_FILE="$HOME/linux-toolbox-data/logs/tool.log"
```

| 配置项 | 说明 |
| --- | --- |
| `BACKUP_DIR` | 备份文件存储目录 |
| `KEEP_DAYS` | 普通备份文件和压缩包的保留天数 |
| `LOG_FILE` | 备份命令日志文件 |

可以通过环境变量临时指定其他配置文件：

```bash
TOOL_CONFIG_FILE=/path/to/config.conf ./src/tool.sh info
```

配置文件使用 Bash 语法，并由程序通过 `source` 加载，应仅使用可信配置文件。

## 测试方法

从项目根目录运行完整测试：

```bash
bash tests/run_test.sh
```

测试套件使用临时目录隔离用户数据，当前覆盖：

- `info` 信息输出
- 单文件备份
- 历史文件清理
- 备份目录压缩及压缩内容
- CLI 的 `help`、`version` 和未知命令

运行 Bash 语法检查和 ShellCheck：

```bash
bash tests/check_code.sh
```

单独执行与 CI 相同的检查：

```bash
bash -n src/*.sh
bash -n src/lib/*.sh
bash -n tests/*.sh

shellcheck src/*.sh
shellcheck src/lib/*.sh
shellcheck tests/*.sh
```

运行代码检查前需要安装 `shellcheck`。

## CI 说明

项目通过 `.github/workflows/test.yml` 配置 GitHub Actions。每次 push 和 pull request 都会在 `ubuntu-latest` 上执行：

1. 检出仓库代码
2. 安装 ShellCheck
3. 对 `src/`、`src/lib/` 和 `tests/` 中的脚本运行 `bash -n`
4. 对相同脚本运行 ShellCheck
5. 执行 `bash tests/run_test.sh`

任意步骤返回非零状态时，CI 作业失败。

## 技术栈

- Bash Shell
- Linux 文件系统与权限管理
- GNU Coreutils：`cp`、`ls`、`du`、`date` 等
- `find`：历史文件查找和清理
- `tar`：备份目录压缩
- ShellCheck：Shell 静态检查
- Git 与 GitHub
- GitHub Actions
