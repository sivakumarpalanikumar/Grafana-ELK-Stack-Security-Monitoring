#!/bin/bash
echo "🚀 ELK Security Monitor Setup Started..."

# Create docker-compose file
cat > docker-compose-elk.yml << 'EOF'
version: '3.7'
services:
  elasticsearch:
    image: elasticsearch:7.17.0
    container_name: es-security
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ports:
      - "9200:9200"
    networks:
      - elk-net

  kibana:
    image: kibana:7.17.0
    container_name: kb-security
    ports:
      - "5601:5601"
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    networks:
      - elk-net
    depends_on:
      - elasticsearch

networks:
  elk-net:
    driver: bridge
EOF

# Stop any existing and start new
docker-compose -f docker-compose-elk.yml down
docker-compose -f docker-compose-elk.yml up -d

echo "⏳ Waiting for ELK to start..."
sleep 30

echo "✅ ELK Stack Ready!"
echo "📊 Kibana: http://localhost:5601"
echo "🐘 Elasticsearch: http://localhost:9200"