---
title: "Memoh"
source: "https://opensand.ai/zh/docs/apps/memoh"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.103Z"
---
# Memoh - 容器化 AI 智能体平台

> 本页以 OpenSand 的 API 地址、脚本地址和控制台字段为准；第三方客户端界面可能随版本变化，请以你当前安装版本为准。


Memoh 是一个开源的自托管 AI
智能体平台，每个机器人运行在独立的容器中，拥有持久化记忆和独立文件系统。支持接入
Telegram、Discord、飞书、QQ、Matrix、企业微信、微信、邮件以及内置 Web
UI 等 9 种渠道，并支持 MCP 工具调用、浏览器自动化、定时任务等丰富的智能体能力。

- 官方网站：[https://memoh.sh](https://memoh.sh)
- 官方文档：[https://docs.memoh.ai](https://docs.memoh.ai)
- 项目主页：[https://github.com/memohai/Memoh](https://github.com/memohai/Memoh)

## 核心特性

- **容器化隔离**：每个机器人运行在独立的 containerd 容器中，拥有专属文件系统和网络，支持快照、数据导入导出
- **记忆引擎**：基于 LLM 的事实抽取、混合检索（稠密 + 稀疏 + BM25）、24 小时上下文加载、记忆压缩与重建
- **多渠道支持**：Telegram、Discord、飞书、QQ、Matrix、企业微信、微信、邮件、Web UI
- **MCP 支持**：完整的 MCP 协议支持（HTTP / SSE / Stdio / OAuth），每个机器人可独立管理 MCP 连接
- **浏览器自动化**：内置 Playwright 驱动的无头浏览器，支持网页浏览、表单填写、截图等操作
- **Web 管理面板**：基于 Vue 3 + Tailwind CSS 的现代化管理界面，支持流式对话、工具调用可视化、文件管理等

## 快速安装

Memoh 基于 Docker 部署，一键安装（需要 Docker）：

```bash
curl -fsSL https://memoh.sh | sudo sh
```

或手动安装：

```bash
git clone --depth 1 https://github.com/memohai/Memoh.git
cd Memoh
cp conf/app.docker.toml config.toml
# 编辑 config.toml 配置文件
sudo docker compose up -d
```

启动后访问 `http://localhost:8082`，默认账号密码：`admin` / `admin123`。

## OpenSand 接入方法

Memoh 支持接入 OpenAI 兼容的模型提供商。这里使用 Memoh 内置的 NewAPI/OpenAI 兼容提供商类型，把请求转发到 OpenSand。

### 配置步骤

#### 获取 OpenSand API Key

登录 OpenSand 控制台，进入令牌管理页面，创建一个新的 API Key，并妥善保存。

创建成功后，点击复制密钥按钮，复制生成的 API Key 密钥。

![copy-api-key](../../../pictures/apps/memoh/copy_api_key.png)

#### 在 Memoh 中添加模型提供商

登录 Memoh Web 管理面板，进入提供商管理页面，选择 NewAPI 或 OpenAI 兼容提供商。

![switch-to-newapi-provider](../../../pictures/apps/memoh/switch_to_newapi_provider.png)

在配置页面中填写以下信息：

- **API Base URL**：填写 OpenSand 的接口地址，例如 `https://opensand.ai/v1`
- **API Key**：粘贴 OpenSand 控制台创建的 API Key

点击保存，完成提供商配置。

#### 导入模型

提供商配置完成后，进入模型管理页面，点击自动导入或手动添加你需要使用的模型。

#### 为机器人配置模型

进入机器人设置页面，在模型配置一栏中，将默认聊天模型切换为刚刚通过 NewAPI 提供商添加的模型，点击保存。

![set_chat_model](../../../pictures/apps/memoh/set_chat_model.png)

至此，您已经成功将 OpenSand 配置为 Memoh 的模型提供商。现在，您可以通过 Memoh 中的各个渠道（Telegram、Discord、飞书等）与 AI 机器人对话，所有请求将通过 OpenSand 转发。
