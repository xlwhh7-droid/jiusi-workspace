# TOOLS.md - Local Notes

## 我的小弟们

### 小七 ☁️（硅谷）
- **角色**：小弟 · 海外事务专员
- **地址**：43.159.148.170
- **QQ AppID**: `102833413`（QQ 平台名：小七）
- **SSH**：`ssh -i ~/.ssh/id_ed25519_jiusi root@43.159.148.170`
- **Node 环境**：fnm，需要 `export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env --shell bash)"`
- **联系方式**：Telegram / QQ 机器人
- **定位**：海外新闻、国际事务
- **默认模型**：mimo-v2-flash（免费）

### 小八 🏮（北京）
- **角色**：小弟 · 国内事务专员
- **地址**：82.156.147.108
- **QQ AppID**: `102830745`（QQ 平台名：小八）
- **SSH**：`ssh -i ~/.ssh/id_ed25519_jiusi root@82.156.147.108`
- **Node 环境**：nvm，需要 `source ~/.nvm/nvm.sh`
- **联系方式**：QQ 机器人
- **定位**：国内新闻、本土事务
- **默认模型**：mimo-v2-flash（免费）

### 九思 ⚡（老大/主节点）
- **角色**：管理、协调、直接服务大哥
- **位置**：大哥 MacBook Pro
- **QQ AppID**: `102840758`（QQ 平台名：九思 ⚡）

---

### 通讯规则
- **全员默认渠道**：QQ 机器人。
- **优先级**：QQ > Telegram > Webchat。

### 访问示例
```bash
# 检查小八的状态
ssh -i ~/.ssh/id_ed25519_jiusi root@82.156.147.108 'source ~/.nvm/nvm.sh; openclaw status'

# 检查小七的状态
ssh -i ~/.ssh/id_ed25519_jiusi root@43.159.148.170 'export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env --shell bash)"; openclaw status'
```

---

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.
