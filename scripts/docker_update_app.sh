
#!/bin/sh

# Check for docker-compose file
if [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then
    echo "Docker Compose file found. Starting services..."
    docker compose down
    docker compose up -d --pull=always --wait
else
    echo "No docker-compose.yml or docker-compose.yaml found in the current directory."
    exit 1
fi
