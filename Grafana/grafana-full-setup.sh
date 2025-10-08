#!/bin/bash
echo "🎯 Starting Complete Grafana Security Setup..."

# Make scripts executable
chmod +x grafana-security-setup.sh
chmod +x send-security-metrics.sh
chmod +x import-dashboard.sh

# Step 1: Setup infrastructure
echo "📦 Step 1/3: Setting up Grafana and Loki..."
./grafana-security-setup.sh

# Step 2: Send data
echo "📊 Step 2/3: Sending security metrics..."
./send-security-metrics.sh

# Step 3: Import dashboard
echo "📋 Step 3/3: Importing security dashboard..."
./import-dashboard.sh

echo ""
echo "🎉 SETUP COMPLETE!"
echo "📊 Access: http://localhost:3000"
echo "👤 Login: admin/admin"
echo "🔍 Dashboard: Security Monitoring Dashboard"
echo ""
echo "Your 4 security metrics are now visible:"
echo "✅ IP Connections | ✅ Open Ports"
echo "✅ Running Containers | ✅ ARP Entries"