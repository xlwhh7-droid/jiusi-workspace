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

### 小弟信息
- **小七** ☁️（硅谷）：43.159.148.170 - 海外事务
- **小八** 🏮（北京）：82.156.147.108 - 国内事务
