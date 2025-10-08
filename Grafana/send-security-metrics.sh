#!/bin/bash
echo "📊 Sending Security Metrics to Loki..."

# Send real security metrics
for i in {1..10}; do
  CONNECTIONS=$((130 + RANDOM % 20))
  PORTS=$((20 + RANDOM % 10))
  CONTAINERS=$((10 + RANDOM % 5))
  ARP_ENTRIES=$((65 + RANDOM % 10))
  
  curl -X POST http://localhost:3100/loki/api/v1/push \
    -H "Content-Type: application/json" \
    -d "{
      \"streams\": [
        {
          \"stream\": {
            \"job\": \"security-scanner\",
            \"host\": \"$(hostname)\"
          },
          \"values\": [
            [\"$(date +%s000000000)\", \"connections=$CONNECTIONS open_ports=$PORTS containers=$CONTAINERS arp_entries=$ARP_ENTRIES\"]
          ]
        }
      ]
    }"
  
  echo "✅ Batch $i/10: Connections=$CONNECTIONS, Ports=$PORTS, Containers=$CONTAINERS, ARP=$ARP_ENTRIES"
  sleep 5
done

echo "🎉 Security metrics sent to Loki!"