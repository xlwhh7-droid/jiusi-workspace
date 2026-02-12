const fs = require('fs');
const readline = require('readline');

const files = [
  '/Users/xl/.openclaw/agents/main/sessions/396118fd-2525-4188-b928-e9d6414eacd6.jsonl',
  '/Users/xl/.openclaw/agents/main/sessions/ad6d6d04-55d9-4bf6-aafe-399dc71f67c4.jsonl',
  '/Users/xl/.openclaw/agents/main/sessions/2488070d-1bd1-4535-8d81-8b437d37d758.jsonl'
];

const START_TIME = new Date('2026-02-11T15:17:00Z').getTime();

let stats = {
  totalInput: 0,
  totalOutput: 0,
  heartbeatInput: 0,
  heartbeatCount: 0,
  peakContext: 0,
  compactionCount: 0,
  messageCount: 0,
  heartbeatMessages: 0
};

async function processFile(file) {
  const fileStream = fs.createReadStream(file);
  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });

  let inHeartbeat = false;
  let lastContext = 0;

  for await (const line of rl) {
    if (!line.trim()) continue;
    try {
      const entry = JSON.parse(line);
      const ts = new Date(entry.timestamp).getTime();
      if (ts < START_TIME) continue;

      if (entry.type === 'message' && entry.message) {
        const msg = entry.message;
        stats.messageCount++;

        // Detect Heartbeat Trigger (User Message)
        if (msg.role === 'user') {
          let text = '';
          if (Array.isArray(msg.content)) {
            text = msg.content.filter(c => c.type === 'text').map(c => c.text).join(' ');
          } else if (typeof msg.content === 'string') {
            text = msg.content;
          }
          
          if (text && text.includes('HEARTBEAT.md')) {
            inHeartbeat = true;
            stats.heartbeatCount++;
          } else {
            inHeartbeat = false; // Reset if user says something else
          }
        }

        // Tally Usage (Assistant Message)
        if (msg.usage) {
           const input = msg.usage.input || msg.usage.inputTokens || 0;
           const output = msg.usage.output || msg.usage.outputTokens || 0;
           
           stats.totalInput += input;
           stats.totalOutput += output;

           if (input > stats.peakContext) stats.peakContext = input;

           if (inHeartbeat) {
             stats.heartbeatInput += input;
             stats.heartbeatMessages++;
           }

           // Detect Compaction
           // Heuristic: Input drops by >30% while context > 10k
           if (lastContext > 10000 && input < lastContext * 0.7) {
             // console.log(`Compaction suspected: ${lastContext} -> ${input} in ${file}`);
             stats.compactionCount++;
           }
           lastContext = input;
        }
      }
    } catch (e) {
      // ignore
    }
  }
  console.log(`File: ${file}`);
  console.log(`  Total Input: ${stats.totalInput}`);
  console.log(`  Heartbeat Input: ${stats.heartbeatInput}`);
  console.log(`  Peak Context: ${stats.peakContext}`);
  console.log(`  Heartbeat Count: ${stats.heartbeatCount}`);
  console.log(`  Compaction Count: ${stats.compactionCount}`);
}

async function run() {
  for (const file of files) {
    if (fs.existsSync(file)) {
      stats = { // Reset all stats per file
        totalInput: 0,
        totalOutput: 0,
        heartbeatInput: 0,
        heartbeatCount: 0,
        peakContext: 0,
        compactionCount: 0,
        messageCount: 0,
        heartbeatMessages: 0
      };
      await processFile(file);
    }
  }
}

run();
