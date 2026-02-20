#!/bin/bash
# Gateway Self-Healing Script
# Checks Gateway health and restarts if needed

LOGFILE="$HOME/.openclaw/logs/gateway-health.log"
PIDFILE="$HOME/.openclaw/run/gateway.pid"

# Check if gateway is responding via RPC
if curl -s --max-time 5 http://127.0.0.1:18789/api/status > /dev/null 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') OK - Gateway healthy" >> "$LOGFILE"
    exit 0
fi

# If not responding, check if process exists
if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') WARN - Gateway stuck, killing PID $PID" >> "$LOGFILE"
        kill -9 "$PID"
        sleep 2
    fi
fi

# Restart
echo "$(date '+%Y-%m-%d %H:%M:%S') INFO - Restarting Gateway..." >> "$LOGFILE"
openclaw gateway restart
sleep 3

# Verify
if curl -s --max-time 5 http://127.0.0.1:18789/api/status > /dev/null 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') DONE - Gateway restarted successfully" >> "$LOGFILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') FAIL - Gateway restart failed" >> "$LOGFILE"
fi
