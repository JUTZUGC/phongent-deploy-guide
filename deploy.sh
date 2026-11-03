#!/usr/bin/env bash
set -euo pipefail
# phongent 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/mylea1/phongent#快速开始
# 更新日期：2026-11-03
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -o phongent.apk https://github.com/mylea1/phongent/releases/latest/download/phongent.apk
adb install -r phongent.apk
echo "每台设备装一次，授予无障碍与通知读取权限后在同一局域网连接"

echo ""

echo "下载与校验完成，安装包在 .download 目录"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/mylea1/phongent#快速开始"
