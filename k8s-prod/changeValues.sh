#!/bin/bash

update_yaml_file() {
    local yaml_file="$1"
    local service="$2"
    local tag_number="$3"
    sed -i "s|image:\s*$service:.*|image: $service:$tag_number|" "$yaml_file"
}

if [ $# -ne 1 ]; then
    echo "Usage: $0 <repository>"
    exit 1
fi

repository="$1"
yaml_file="values.yml"

# Fetch the latest tag from Docker Hub API
response=$(curl -s "https://registry.hub.docker.com/v2/repositories/$repository/tags/")
latest_tag=$(echo "$response" | jq -r '.results | max_by(.last_updated) | .name')

if [ -n "$latest_tag" ]; then
    echo "Latest tag for $repository: $latest_tag"
    for service in "flask1" "flask2" "flask3"; do
        update_yaml_file "$yaml_file" "$service" "$latest_tag"
    done
else
    echo "Failed to retrieve latest tag for $repository"
fi
