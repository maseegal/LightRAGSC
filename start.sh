#!/bin/bash

echo "Waiting for Neo4j to be ready on neo4j:7687..."

for i in {1..60}; do
  nc -z neo4j 7687 && break
  echo "Attempt $i: Neo4j not ready"
  sleep 1
done

if ! nc -z neo4j 7687; then
  echo "Neo4j not available after 60 seconds. Exiting."
  exit 1
fi

echo "Neo4j is up. Starting LightRAG server."
exec python -m lightrag.api.lightrag_server
