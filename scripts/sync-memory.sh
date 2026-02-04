#!/bin/bash
# 记忆同步脚本 - 使用 Git 实现双向同步

set -e
SSH_KEY="$HOME/.ssh/id_ed25519_jiusi"
LOCAL_DIR="/Users/xl/clawd"
SILICON_VALLEY="root@43.159.148.170"
BEIJING="root@82.156.147.108"
REMOTE_DIR="/root/jiusi"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# 1. 本地先提交并推送
log "本地提交..."
cd "$LOCAL_DIR"
git add -A
git diff --cached --quiet || git commit -m "sync: $(date '+%Y-%m-%d %H:%M')" || true
git push origin main 2>/dev/null || git push origin master 2>/dev/null || log "本地推送失败（可能没有新提交）"

# 2. 硅谷服务器拉取（保留本地 IDENTITY.md）
log "同步硅谷服务器..."
ssh -i "$SSH_KEY" "$SILICON_VALLEY" "
  cd $REMOTE_DIR
  cp IDENTITY.md /tmp/IDENTITY.md.bak 2>/dev/null || true
  git fetch origin 2>/dev/null || true
  git reset --hard origin/main 2>/dev/null || git reset --hard origin/master 2>/dev/null || true
  cp /tmp/IDENTITY.md.bak IDENTITY.md 2>/dev/null || true
" 2>&1 || log "硅谷同步警告（可能需要手动处理）"

# 3. 北京服务器拉取（保留本地 IDENTITY.md）
log "同步北京服务器..."
ssh -i "$SSH_KEY" "$BEIJING" "
  cd $REMOTE_DIR
  cp IDENTITY.md /tmp/IDENTITY.md.bak 2>/dev/null || true
  git fetch origin 2>/dev/null || true
  git reset --hard origin/main 2>/dev/null || git reset --hard origin/master 2>/dev/null || true
  cp /tmp/IDENTITY.md.bak IDENTITY.md 2>/dev/null || true
" 2>&1 || log "北京同步警告（可能需要手动处理）"

log "同步完成"
