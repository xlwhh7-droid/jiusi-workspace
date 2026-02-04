#!/bin/bash
# 记忆同步脚本 - 混合模式：Git（硅谷） + rsync（北京）

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
git push origin main 2>/dev/null || log "本地推送失败（可能没有新提交）"

# 2. 硅谷服务器通过 Git 拉取（保留本地 IDENTITY.md）
log "同步硅谷服务器 (Git)..."
ssh -i "$SSH_KEY" "$SILICON_VALLEY" "
  cd $REMOTE_DIR
  cp IDENTITY.md /tmp/IDENTITY.md.bak 2>/dev/null || true
  git fetch origin 2>/dev/null
  git reset --hard origin/main 2>/dev/null || git reset --hard origin/master 2>/dev/null
  cp /tmp/IDENTITY.md.bak IDENTITY.md 2>/dev/null || true
" 2>&1 || log "硅谷同步警告"

# 3. 北京服务器通过 rsync 同步（备选方案）
log "同步北京服务器 (rsync)..."
# 备份北京的 IDENTITY.md
ssh -i "$SSH_KEY" "$BEIJING" "cp $REMOTE_DIR/IDENTITY.md /tmp/IDENTITY.md.bak 2>/dev/null || true"

# 同步文件（排除 IDENTITY.md 和 .git）
rsync -avz --exclude='.git' --exclude='IDENTITY.md' -e "ssh -i $SSH_KEY" \
  "$LOCAL_DIR/memory/" "$BEIJING:$REMOTE_DIR/memory/"

rsync -avz -e "ssh -i $SSH_KEY" \
  "$LOCAL_DIR/MEMORY.md" \
  "$LOCAL_DIR/SOUL.md" \
  "$LOCAL_DIR/USER.md" \
  "$LOCAL_DIR/AGENTS.md" \
  "$BEIJING:$REMOTE_DIR/"

# 恢复北京的 IDENTITY.md
ssh -i "$SSH_KEY" "$BEIJING" "cp /tmp/IDENTITY.md.bak $REMOTE_DIR/IDENTITY.md 2>/dev/null || true"

log "同步完成"
