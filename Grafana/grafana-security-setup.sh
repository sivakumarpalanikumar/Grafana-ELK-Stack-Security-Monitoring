bash
#!/bin/bash
echo "🚀 Grafana Security Monitor Setup Started..."

# Create docker-compose file
cat > docker-compose-grafana.yml << 'EOF'
version: '3.7'
services:
  loki:
    image: grafana/loki:2.8.0
    container_name: loki-security
    ports:
      - "3100:3100"
    command: -config.file=/etc/loki/local-config.yaml
    networks:
      - grafana-net

  grafana:
    image: grafana/grafana:9.5.0
    container_name: grafana-security
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    networks:
      - grafana-net
    depends_on:
      - loki

networks:
  grafana-net:
    driver: bridge
EOF

# Stop any existing and start new
docker-compose -f docker-compose-grafana.yml down
docker-compose -f docker-compose-grafana.yml up -d

echo "⏳ Waiting for Grafana to start..."
sleep 30

echo "✅ Grafana Stack Ready!"
echo "📊 Grafana: http://localhost:3000 (admin/admin)"
echo "📝 Loki: http://localhost:3100"