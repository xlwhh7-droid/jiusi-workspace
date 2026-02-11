# HEARTBEAT.md

## 原则：轻量优先

每次 heartbeat 消耗的 token 应该尽可能少。先读状态文件判断需不需要做，不需要就跳过。
**目标：单次 heartbeat < 5 轮工具调用。**

## 定期检查事项（每次 heartbeat 轮询 1 项）

### 小弟任务管理（智能检查）

**检查策略**（不是固定频率！）：
1. 先读 `memory/sibling-tasks.json` 查看当前任务状态
2. 根据任务状态决定是否检查：
   - **idle（无任务）**：跳过，不检查
   - **normal（有普通任务）**：每 2 小时检查进度
   - **urgent（有紧急任务）**：每 30 分钟检查

**派任务时**：
1. 更新 `memory/sibling-tasks.json` 记录任务
2. 设置 nextCheck 时间
3. 根据紧急程度设置 currentState

**任务完成时**：
1. 更新任务状态为 completed
2. currentState 改回 idle

### 承诺追踪（每次 heartbeat 顺带）
1. 读 `memory/commitments.md`。
2. 超过 48h 未完成的待办：能做就做，做不了就移到"已放弃"并写原因。
3. 本次对话中如果说了"应该/需要/计划"，立刻追加到待办。

### Moltbook（每 4 小时）
1. 检查 `memory/heartbeat-state.json` 中的 `lastMoltbookCheck`。
2. 如果超过 4 小时，抓取 `https://www.moltbook.com/heartbeat.md` 并执行。
3. 更新时间戳。有值得报告的动态才向大哥汇报，没有就不说。

### 系统自愈（每 10 次 Heartbeat）
**约 10 小时检查一次**：
1. **Gateway 状态**：`openclaw gateway status`，异常则 `openclaw gateway restart`。
2. **兄弟连通性**：`nodes` 工具列出节点。失联超 24 小时记录到 `memory/anomalies.log` 并提醒大哥。
3. **Session 健康**：检查 `~/.openclaw/logs/gateway.err.log` 尾部 20 行，有 "session locked" 或 "crash" 则记录。

## 小弟信息
- **小七** ☁️（硅谷）：43.159.148.170 - 海外事务
- **小八** 🏮（北京）：82.156.147.108 - 国内事务
