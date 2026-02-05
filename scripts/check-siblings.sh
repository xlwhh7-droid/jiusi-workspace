#!/bin/bash
# 小七和小八状态监控脚本
# 九思（小九）的小弟管理工具

SSH_KEY="$HOME/.ssh/id_ed25519_jiusi"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

log "=== 检查小弟状态 ==="

# 检查小七（硅谷）
log "检查小七（硅谷）..."
ssh -i "$SSH_KEY" -o ConnectTimeout=10 root@43.159.148.170 'export PATH="$HOME/.local/share/fnm:$PATH"; eval "$(fnm env --shell bash)"; openclaw health 2>&1 | head -5' 2>/dev/null || log "⚠️ 小七连接失败"

# 检查小八（北京）
log "检查小八（北京）..."
ssh -i "$SSH_KEY" -o ConnectTimeout=10 root@82.156.147.108 'source ~/.nvm/nvm.sh; openclaw health 2>&1 | head -5' 2>/dev/null || log "⚠️ 小八连接失败"

log "=== 检查完成 ==="
