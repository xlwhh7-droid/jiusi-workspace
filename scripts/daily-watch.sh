#!/bin/bash
# 每日专项追踪脚本

LOG_FILE="/Users/xl/clawd/logs/daily-watch.log"
REPORT_FILE="/tmp/daily-watch-report.md"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "开始每日追踪..."

# 创建报告
cat > "$REPORT_FILE" << 'EOF'
# 📰 每日专项追踪报告

EOF

echo "**生成时间**: $(date '+%Y-%m-%d %H:%M')" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 1. OpenClaw 版本检查
echo "## 1. OpenClaw 升级动态" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

CURRENT_VERSION=$(openclaw --version 2>/dev/null || echo "未知")
echo "**当前版本**: $CURRENT_VERSION" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查 GitHub releases
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/openclaw/openclaw/releases/latest" 2>/dev/null | jq -r '.tag_name // "无法获取"')
echo "**最新发布**: $LATEST_RELEASE" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

if [ "$CURRENT_VERSION" != "$LATEST_RELEASE" ] && [ "$LATEST_RELEASE" != "无法获取" ] && [ "$LATEST_RELEASE" != "null" ]; then
  echo "⚠️ **有新版本可用！** 请考虑更新。" >> "$REPORT_FILE"
else
  echo "✅ 已是最新版本" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# 2. 配置界面语言检查
echo "## 2. 配置界面中文版" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查文档中是否有语言相关配置
if grep -r "language\|locale\|i18n\|中文" /opt/homebrew/lib/node_modules/openclaw/docs/ 2>/dev/null | grep -v ".git" | head -5 > /dev/null; then
  echo "发现语言相关配置，可能支持多语言。" >> "$REPORT_FILE"
else
  echo "⏳ 暂未发现中文支持配置，持续关注中..." >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# 3. 行业动态（从 blogwatcher 获取）
echo "## 3. AI Agent 行业动态" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 扫描新文章
blogwatcher scan 2>/dev/null

# 获取未读文章
ARTICLES=$(blogwatcher articles --unread 2>/dev/null | head -20)
if [ -n "$ARTICLES" ]; then
  echo "### 最新文章" >> "$REPORT_FILE"
  echo '```' >> "$REPORT_FILE"
  echo "$ARTICLES" >> "$REPORT_FILE"
  echo '```' >> "$REPORT_FILE"
else
  echo "暂无新文章" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# 4. 相关资源汇总
echo "## 4. 推荐资源" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
cat >> "$REPORT_FILE" << 'EOF'
### AI Agent 相关社区

| 资源 | 链接 | 说明 |
|------|------|------|
| OpenClaw 官方 | https://docs.openclaw.ai | 官方文档 |
| OpenClaw Discord | https://discord.com/invite/clawd | 社区讨论 |
| ClawHub | https://clawhub.com | 技能市场 |
| Anthropic Blog | https://www.anthropic.com/news | Claude 动态 |
| LangChain | https://blog.langchain.dev | Agent 框架 |
| Hacker News | https://news.ycombinator.com | 技术热点 |

EOF

echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "*九思 ⚡ 为您追踪*" >> "$REPORT_FILE"

log "报告生成完成: $REPORT_FILE"

# 输出报告内容
cat "$REPORT_FILE"
