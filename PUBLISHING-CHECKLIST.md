# 发布前核对清单

- 确认站点根目录部署后包含 `zh/`、`en/`、`scripts/`、`pictures/` 四个目录。
- 将 `opensand-docs/scripts/*` 部署到 `https://opensand.ai/scripts/*`。
- 重新运行品牌审计脚本，确认没有未处理的上游品牌字段。
- 逐页检查第三方工具配置示例，确认 provider 名称和 Base URL 与工具实际兼容。
- 重新截取 OpenSand 控制台图片，替换 `opensand-docs/pictures/apps/...` 下的资源。
- 高风险文档默认排除；只有确认 OpenSand 已支持时再恢复。
