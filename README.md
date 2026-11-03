# phongent 一键安装指南

> 第三方部署指南 · 非 phongent 官方仓库。官方项目：[mylea1/phongent](https://github.com/mylea1/phongent)
> 内容来自官方文档（2026-11-03）。项目迭代快，请以[官方文档](https://github.com/mylea1/phongent#快速开始)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把安装包下载并校验好。

⚠️ Android 版可直接做主控与执行端，iOS 需用 Xcode 自行构建签名。最低 Android 11；主控与执行端必须在同一局域网，并在手机端授予无障碍、通知读取等权限。不要用上游项目的 APK 替代，可能缺少群控接口。模型需在每台设备上单独配置并计费。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/phongent-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会下载 Android 安装包并用 adb 安装，再提示在同一局域网连接设备，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## phongent 是什么？

phongent 是开源的一句话把任务拆给多台手机，进度、消息与实时画面都在一个面板里（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/mylea1/phongent?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

多设备 agent 协作：在一台手机上分配任务，多台设备分组执行，实时查看进度、消息与画面，支持一键连接与重连。

- 多设备分组与任务下发
- 一个界面看全部进度
- 实时画面与消息
- 已授权设备支持重连
- Android 主控兼执行
- Apache-2.0，可改

（来源：[官方仓库](https://github.com/mylea1/phongent)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 328 stars | 名称搜索仅 1 条结果 |
| 多设备分组与统一面板 | — |
| Android 主控兼执行 | — |
| 支持重连与实时画面 | — |
| Apache-2.0 | 可商用 |
| 项目文档较完整 | — |

| 需要注意 | 说明 |
|---|---|
| iOS 需自行签名 | — |
| 必须同一局域网 | — |
| 权限配置较繁琐 | — |
| 多设备模型费用叠加 | — |
| 项目较新 | 接口可能变 |

> 以上基于官方文档与社区反馈整理（2026-11-03），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o phongent.apk https://github.com/mylea1/phongent/releases/latest/download/phongent.apk
adb install -r phongent.apk
echo "每台设备装一次，授予无障碍与通知读取权限后在同一局域网连接"
```

安装包来源：[https://github.com/mylea1/phongent#快速开始](https://github.com/mylea1/phongent#快速开始)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 Android 11+、iOS 自签与同局域网要求 | 已核对 2026-11-03 |
| 未实测安装与多设备连接 | 说明 2026-11-03 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-03 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-03 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装步骤、权限与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-03）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\phongent-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装

| 平台 | 方式 |
|---|---|
| Android | 直接装 APK，主控与执行端同一个应用 |
| iOS | Xcode 构建并自签 |

## 第一次使用

1. 每台设备装 APK
2. 在应用内配置模型与手机操作权限
3. 主控与执行端连同一局域网
4. 主控「设备」页一键连接，首次在手机端允许
5. agent 页选设备或分组，输入任务

## 权限

- 无障碍服务
- 通知读取
- 部分机型需要后台保活

## 注意

- 每台设备的模型 Key 与费用单独算
- iOS 需要开发者签名，7 天可能过期
- 只用自己拥有或获授权的设备
- 不要用上游 APK 代替执行端
- Apache-2.0，可商用可二开

## 常见坑

- 连不上设备：确认同一局域网与执行端服务在跑
- 权限不生效：逐项检查无障碍与通知读取
- 装错包：不要用上游 APK，缺少群控接口
- iOS 掉签：重新签名安装
- 任务卡住：检查执行端模型配置与余额
- 后台被杀：给应用加电池白名单
- 设备重命名不同步：确认执行端支持该接口

## 免责声明

本仓库为第三方指南，与 phongent 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-03），项目迭代快，请以[官方文档](https://github.com/mylea1/phongent#快速开始)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
