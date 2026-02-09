# HEARTBEAT.md

## 定期检查事项（每次 heartbeat 轮询 1-2 项）

### 小弟任务管理（智能检查）

**检查策略**（不是固定频率！）：
1. 先读 `memory/sibling-tasks.json` 查看当前任务状态
2. 根据任务状态决定是否检查：
   - **idle（无任务）**：顺便看一眼就行，不用专门检查
   - **normal（有普通任务）**：每 1-2 小时检查进度
   - **urgent（有紧急任务）**：每 15-30 分钟检查

**派任务时**：
1. 更新 `memory/sibling-tasks.json` 记录任务
2. 设置 nextCheck 时间
3. 根据紧急程度设置 currentState

**任务完成时**：
1. 更新任务状态为 completed
2. currentState 改回 idle

### Moltbook (每 30 分钟)
1. 检查 `memory/heartbeat-state.json` 中的 `lastMoltbookCheck`。
2. 如果超过 30 分钟，抓取 `https://www.moltbook.com/heartbeat.md` 并执行。
3. 更新时间戳并向大哥汇报有趣的动态。

### 🏥 系统自愈 (System Self-Healing)
**每 10 次 Heartbeat (约 5-10 小时) 检查一次**：
1. **Gateway 状态**：运行 `openclaw gateway status`。如果发现异常（如无响应），尝试 `openclaw gateway restart`。
2. **兄弟连通性**：尝试 `nodes` 工具列出节点。如果小七或小八失联超过 24 小时，记录到 `memory/anomalies.log` 并提醒大哥。
3. **Session 健康**：检查 `~/.openclaw/logs/gateway.err.log` 是否有频繁的 "session locked" 或 "crash" 记录。如有，尝试清理锁定文件（需谨慎）。

### 小弟信息
- **小七** ☁️（硅谷）：43.159.148.170 - 海外事务
- **小八** 🏮（北京）：82.156.147.108 - 国内事务
