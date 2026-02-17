# TOOLS.md - Local Notes

## 我的兄弟们

### 小七 ☁️（硅谷）
- **角色**：海外事务专员
- **地址**：43.159.148.170
- **QQ AppID**: `102833413`（QQ 平台名：小七）
- **SSH**：`ssh -i ~/.ssh/id_ed25519_jiusi root@43.159.148.170`
- **Node 环境**：fnm，需要 `export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env --shell bash)"`
- **联系方式**：Telegram / QQ 机器人
- **定位**：海外新闻、国际事务
- **默认模型**：google-antigravity/gemini-3-flash

### 小八 🏮（北京）
- **角色**：国内事务专员
- **地址**：82.156.147.108
- **QQ AppID**: `102830745`（QQ 平台名：小八）
- **SSH**：`ssh -i ~/.ssh/id_ed25519_jiusi root@82.156.147.108`
- **Node 环境**：nvm，需要 `source ~/.nvm/nvm.sh`
- **联系方式**：QQ 机器人
- **定位**：国内新闻、本土事务
- **默认模型**：xiaomi/mimo-v2-flash

### 安卓节点 📱 (Pixel 6 Pro)
- **角色**：移动端/本地网关
- **局域网 IP**：192.168.50.89
- **ADB ID**: `1A281FDEE0015U`
- **Token**: `phone6pro2026`
- **远程连接 (Mac)**:
  - 端口转发: `adb forward tcp:28789 tcp:18789`
  - 访问地址: `http://localhost:28789/?token=phone6pro2026`
  - 调试转发: `adb forward tcp:9224 localabstract:chrome_devtools_remote`
- **启动脚本**: `/sdcard/start_gw.sh`

### 我 — 九思 ⚡（主节点）
- **角色**：老大，管理、协调、直接服务大哥
- **位置**：大哥 MacBook Pro
- **QQ AppID**: `102840758`（QQ 平台名：九思 ⚡）
- **默认模型**：google-antigravity/gemini-3-flash

---

### 通讯规则
- **全员默认渠道**：QQ 机器人
- **优先级**：QQ > Telegram > Webchat

### 模型规则
- **未经大哥明确同意，不得修改任何人的大语言模型配置**
- 九思、小七：Google（gemini-3-flash）
- 小八：小米（mimo-v2-flash）

### 外部 API

#### Perplexity API
- **Key**: 已配置在 `openclaw.json` 的 `tools.web.search` 中，不在此处明文存储

---

### 🤝 协作协议 (Collaboration Protocol)
**跨 Agent 通信 (`sessions_send`) 必须遵循以下 JSON 结构**：

#### Request (请求)
```json
{
  "type": "request",
  "task": "任务简述 (e.g. 抓取推文)",
  "details": "详细要求 (e.g. @servasyy_ai 最近 10 条, 带互动数据)",
  "format": "markdown | json | summary",
  "deadline": "ISO-8601 (可选)"
}
```

#### Response (响应)
```json
{
  "type": "response",
  "status": "success | error",
  "result": "结果摘要 (或文件路径)",
  "artifacts": ["path/to/file1", "path/to/file2"]
}
```
*原则：结构化通信 > 自然语言闲聊。确保机器可读。*

### 访问示例
```bash
# 检查小八的状态
ssh -i ~/.ssh/id_ed25519_jiusi root@82.156.147.108 'source ~/.nvm/nvm.sh; openclaw status'

# 检查小七的状态
ssh -i ~/.ssh/id_ed25519_jiusi root@43.159.148.170 'export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env --shell bash)"; openclaw status'
```
