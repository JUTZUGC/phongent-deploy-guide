# phongent 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/mylea1/phongent#快速开始
# 更新日期：2026-11-03
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o phongent.apk https://github.com/mylea1/phongent/releases/latest/download/phongent.apk
adb install -r phongent.apk
Write-Host "每台设备装一次，授予无障碍与通知读取权限后在同一局域网连接"

Write-Host ''

Write-Host '下载与校验完成，安装包在 .download 目录'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/mylea1/phongent#快速开始'
