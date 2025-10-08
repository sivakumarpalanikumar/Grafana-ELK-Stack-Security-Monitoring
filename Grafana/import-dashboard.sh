#!/bin/bash
echo "📊 Importing Security Dashboard..."

DASHBOARD_JSON='{
  "dashboard": {
    "title": "Security Monitoring Dashboard",
    "panels": [
      {
        "id": 1,
        "title": "IP Connections",
        "type": "stat",
        "targets": [
          {
            "expr": "{job=\"security-scanner\"} | logfmt | connections",
            "refId": "A"
          }
        ],
        "gridPos": {"h": 8, "w": 12, "x": 0, "y": 0}
      },
      {
        "id": 2,
        "title": "Open Ports",
        "type": "stat",
        "targets": [
          {
            "expr": "{job=\"security-scanner\"} | logfmt | open_ports",
            "refId": "A"
          }
        ],
        "gridPos": {"h": 8, "w": 12, "x": 12, "y": 0}
      },
      {
        "id": 3,
        "title": "Running Containers",
        "type": "stat",
        "targets": [
          {
            "expr": "{job=\"security-scanner\"} | logfmt | containers",
            "refId": "A"
          }
        ],
        "gridPos": {"h": 8, "w": 12, "x": 0, "y": 8}
      },
      {
        "id": 4,
        "title": "ARP Entries",
        "type": "stat",
        "targets": [
          {
            "expr": "{job=\"security-scanner\"} | logfmt | arp_entries",
            "refId": "A"
          }
        ],
        "gridPos": {"h": 8, "w": 12, "x": 12, "y": 8}
      }
    ]
  }
}'

# Import dashboard via API
curl -X POST http://admin:admin@localhost:3000/api/dashboards/db \
  -H "Content-Type: application/json" \
  -d "$DASHBOARD_JSON"

echo "✅ Dashboard imported!"