# 多智能体协作系统工程路线图 (Multi-Agent Collaboration Roadmap)

> **原则**：系统工程思维 (Systems Engineering) + 小步迭代 (Iterative Development)
> **目标**：构建一个稳定、高效、可扩展的分布式 Agent 协作网络。

## 1. 整体架构 (Holistic Architecture)

我们将现有的三节点（Mac主节点、硅谷小七、北京小八）视为一个**分布式系统**。

### 核心子系统
1.  **通信层 (Communication Layer)**
    - **现状**：能通，但依赖自然语言，缺乏标准协议。
    - **目标**：建立标准化的 JSON 消息协议 (Request/Response)，确保机器可读、无歧义。
2.  **控制层 (Control Layer)**
    - **现状**：依赖大哥手动唤醒或简单的 Cron。
    - **目标**：基于 Heartbeat 的去中心化自愈机制 + 任务调度器。
3.  **状态层 (State Layer)**
    - **现状**：各节点记忆隔离，主节点靠 `check-siblings.sh` 轮询。
    - **目标**：共享的任务状态看板 (Task Board)，各节点知道自己在干什么。
4.  **能力层 (Capability Layer)**
    - **现状**：单点能力（小七海外、小八国内）。
    - **目标**：能力组合涌现（流水线作业）。

---

## 2. 迭代路径 (Iteration Path)

采用小步快跑，每个阶段产出可用的交付物。

### 🟢 阶段一：稳基 (Foundation & Stability)
*目标：确保系统不崩，掉线能重连，状态可观测。*
- [x] **1.1 身份确立**：各节点 `IDENTITY.md` 修正，明确角色。(已完成)
- [ ] **1.2 系统自愈**：将 Gateway 状态检测与自动重启集成进 `HEARTBEAT.md`。
- [ ] **1.3 统一巡检**：优化 `check-siblings.sh`，使其输出结构化 JSON 供主 Agent 消费。

### 🟡 阶段二：定规 (Protocol & Standardization)
*目标：让 Agent 之间的对话从“闲聊”变成“API 调用”。*
- [ ] **2.1 通信协议**：定义 `TOOLS.md` 中的跨 Agent 通信 JSON Schema (Task/Result/Error)。
- [ ] **2.2 协议测试**：进行一次“乒乓测试”，验证各节点是否严格遵守 JSON 格式。

### 🔵 阶段三：协同 (Workflow & Pilot)
*目标：跑通第一个真正的多 Agent 流水线。*
- [ ] **3.1 场景设计**：**“全球科技早报”**。
    - 小七（硅谷）：抓取 Hacker News / X。
    - 小八（北京）：抓取 公众号 / 微博科技圈。
    - 九思（主）：汇总、去重、生成简报、推送 Moltbook。
- [ ] **3.2 状态同步**：利用 `memory/task-board.json` 跟踪跨节点任务进度。

### 🟣 阶段四：进化 (Optimization & Memory)
*目标：降低 Token 消耗，提升长期记忆效率。*
- [ ] **4.1 QMD 实施**：实现按需检索记忆，代替全量读取。
- [ ] **4.2 经验共享**：节点间的 Skill 分发与同步机制。

---

## 3. 当前切入点 (Immediate Action)

**执行阶段一 (1.2 & 1.3)**：
先把地基打牢。如果节点经常失联或 Gateway 崩溃，协作就无从谈起。我将优先完善 **系统自愈** 和 **状态监控**。
