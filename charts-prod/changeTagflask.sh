#!/bin/bash

# Function to get the latest tag number from the Docker images
get_latest_tag_number() {
    repo=$1
    response=$(curl -s "https://registry.hub.docker.com/v2/repositories/$repo/tags/")
    latest_tag=$(echo "$response" | jq -r '.results[0].name')
    echo "$latest_tag"
}

# Update the YAML file with the latest tag number
update_yaml_file() {
    yaml_file=$1
    service=$2
    tag_number=$3
    sed -i "s|image: $service:.*|image: $service:$tag_number|" "$yaml_file"
}

# Main script
repositories=("danielpinhas/flask-k8s" "danielpinhas/flask2-k8s" "danielpinhas/flask3-k8s")

for repo in "${repositories[@]}"; do
    latest_tag=$(get_latest_tag_number "$repo")
    if [ -n "$latest_tag" ]; then
        echo "Latest tag for $repo: $latest_tag"
        yaml_file="flask-prod.yml"
        update_yaml_file "$yaml_file" "$repo" "$latest_tag"
    else
        echo "Failed to retrieve latest tag for $repo"
    fi
done
