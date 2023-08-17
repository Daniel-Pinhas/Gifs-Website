#!/bin/bash

repositories=("danielpinhas/flask-k8s" "danielpinhas/flask2-k8s" "danielpinhas/flask3-k8s")

for repository in "${repositories[@]}"; do
    response=$(curl -s "https://registry.hub.docker.com/v2/repositories/$repository/tags/")
    latest_tag=$(echo "$response" | jq -r '.results | max_by(.last_updated) | .name')

    case "$repository" in
        "danielpinhas/flask-k8s")
            sed -i "s|flask1:\s*tag:.*|flask1:\n  image:\n    repository: danielpinhas/flask-k8s\n    tag: $latest_tag|" values.yml
            ;;
        "danielpinhas/flask2-k8s")
            sed -i "s|flask2:\s*tag:.*|flask2:\n  image:\n    repository: danielpinhas/flask2-k8s\n    tag: $latest_tag|" values.yml
            ;;
        "danielpinhas/flask3-k8s")
            sed -i "s|flask3:\s*tag:.*|flask3:\n  image:\n    repository: danielpinhas/flask3-k8s\n    tag: $latest_tag|" values.yml
            ;;
    esac
done
