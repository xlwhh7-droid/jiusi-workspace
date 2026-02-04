# TOOLS.md - Local Notes

## 小九和小八

### 小九 ☁️（硅谷）
- **地址**：43.159.148.170
- **SSH**：`ssh -i ~/.ssh/id_ed25519_jiusi root@43.159.148.170`
- **Node 环境**：fnm，需要 `export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env --shell bash)"`
- **联系方式**：QQ 机器人
- **定位**：海外新闻

### 小八 🏮（北京）
- **地址**：82.156.147.108
- **SSH**：`ssh -i ~/.ssh/id_ed25519_jiusi root@82.156.147.108`
- **Node 环境**：nvm，需要 `source ~/.nvm/nvm.sh`
- **联系方式**：QQ 机器人
- **定位**：国内新闻

### 访问示例
```bash
# 检查小八的 cron 任务
ssh -i ~/.ssh/id_ed25519_jiusi root@82.156.147.108 'source ~/.nvm/nvm.sh; openclaw cron list'

# 检查小九的 cron 任务
ssh -i ~/.ssh/id_ed25519_jiusi root@43.159.148.170 'export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env --shell bash)"; openclaw cron list'
```

---

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.
