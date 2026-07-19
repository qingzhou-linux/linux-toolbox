# Linux Toolbox

一个基于 Bash Shell 开发的 Linux 自动化管理工具。

Linux Toolbox 提供文件备份、压缩、历史清理、状态查看等功能，
帮助用户快速管理 Linux 环境中的文件备份任务。


# 功能特性

- 文件自动备份
- 多文件备份支持
- 备份文件压缩
- 历史备份清理
- 备份状态查看
- 日志记录
- 配置文件管理
- 一键安装为 Linux 命令


# 项目结构


```
linux-toolbox

├── backup
│
├── config
│   └── config.conf
│
├── logs
│
├── src
│   ├── tool.sh
│   ├── backup2.sh
│   ├── backup3.sh
│   └── clean.sh
│
├── tests
│   ├── run_test.sh
│   ├── test_info.sh
│   ├── test_backup.sh
│   └── test_clean.sh
│
├── install.sh
│
├── uninstall.sh
│
└── README.md
```


# 安装


进入项目目录：

```bash
cd linux-toolbox
```


执行安装：

```bash
sudo ./install.sh
```


安装完成后：

```bash
tool
```


即可直接使用。


# 使用方法


## 查看帮助

```bash
tool help
```


## 查看版本

```bash
tool version
```


示例：

```
Linux工具箱版本:1.8
```


## 查看工具信息

```bash
tool info
```


显示：

- 软件版本
- 程序目录
- 配置文件位置
- 备份目录
- 日志文件位置


## 文件备份


备份单个文件：

```bash
tool backup test.txt
```


备份多个文件：

```bash
tool backup file1.txt file2.txt
```


备份文件保存位置：

```
~/linux-toolbox-data/backup
```



## 压缩备份


执行：

```bash
tool compress
```


生成：

```
~/linux-toolbox-data/backup_xxxx.tar.gz
```



## 清理旧备份


执行：

```bash
tool clean
```


根据配置文件中的保留时间自动删除旧备份。


## 查看状态


执行：

```bash
tool status
```


显示：

- 当前备份数量
- 最新备份文件
- 备份大小
- 日志状态



# 配置文件


配置文件：

```
config/config.conf
```


当前配置：

```bash
BACKUP_DIR="$HOME/linux-toolbox-data/backup"

KEEP_DAYS=7

LOG_FILE="$HOME/linux-toolbox-data/logs/tool.log"
```


说明：

|配置|作用|
|-|-|
|BACKUP_DIR|备份文件存储目录|
|KEEP_DAYS|备份保留时间|
|LOG_FILE|日志文件位置|



# 自动化测试


进入测试目录：

```bash
cd tests
```


运行：

```bash
./run_test.sh
```


测试内容：

- info功能测试
- backup功能测试
- clean功能测试


测试结果：

```
info test passed

backup test passed

clean test passed

All Tests Finished
```



# 技术实现


## Shell开发

- Bash Shell
- 参数处理
- 函数封装
- 条件判断
- 循环处理


## Linux技术

- Linux文件系统
- Linux权限管理
- PATH环境变量
- tar压缩
- find文件管理
- 日志系统


## 工程化设计

- 配置文件管理
- 模块化脚本设计
- 自动安装脚本
- 自动化测试
- Git版本管理



# 版本记录


## v1.8

主要更新：

- 重构安装架构
- 支持系统命令 tool
- 修复开发环境和安装环境路径问题
- 分离程序文件和用户数据
- 优化日志管理
- 完善状态查看功能


## v1.7

主要更新：

- 增加自动化测试框架
- 增加测试脚本


## v1.6

主要更新：

- 增加 CLI 命令结构
- 增加 info/status/version 命令


## v1.5

初始版本：

- 文件备份
- 文件压缩
- 历史清理
- 基础配置管理



# 卸载


执行：

```bash
sudo ./uninstall.sh
```


卸载：

- 删除系统命令 tool
- 删除安装目录



# 项目总结


Linux Toolbox 是一个从零开发的 Linux 命令行工具项目。


通过该项目实践：

- Bash Shell脚本开发
- Linux系统管理
- 软件安装流程
- 自动化测试
- Git版本控制


最终实现一个：

**可安装、可运行、可维护的 Linux CLI 工具。**
