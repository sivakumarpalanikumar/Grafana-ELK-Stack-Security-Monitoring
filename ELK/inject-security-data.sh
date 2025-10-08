#!/bin/bash
echo "📊 Injecting Security Metrics..."

# Send sample security data
curl -X POST "localhost:9200/security-logs-2024.01.01/_doc" \
-H "Content-Type: application/json" \
-d '{
  "timestamp": "'$(date -Iseconds)'",
  "connections": 131,
  "open_ports": 22,
  "containers": 11,
  "arp_entries": 68,
  "host": "security-server",
  "type": "network_scan"
}'

echo "✅ Data injected! Open Kibana and follow setup steps."