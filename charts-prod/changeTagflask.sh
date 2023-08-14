#!/bin/bash

# Function to update the YAML file with the latest tag
update_yaml_file() {
    yaml_file=$1
    service=$2
    tag_number=$3
    sed -i "s|image: $service:.*|image: $service:$tag_number|" "$yaml_file"
}

# Check if repository argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <repository>"
    exit 1
fi

# Repository from command-line argument
repository="$1"
yaml_file="flask-prod.yml"

# Retrieve the latest tag for the specified repository
response=$(curl -s "https://registry.hub.docker.com/v2/repositories/$repository/tags/")
latest_tag=$(echo "$response" | jq -r '.results | max_by(.last_updated) | .name')

if [ -n "$latest_tag" ]; then
    echo "Latest tag for $repository: $latest_tag"
    sed_tag="${latest_tag//./\\.}"  # Escape dots for use in sed regex
    update_yaml_file "$yaml_file" "$repository" "$latest_tag"
else
    echo "Failed to retrieve latest tag for $repository"
fi
