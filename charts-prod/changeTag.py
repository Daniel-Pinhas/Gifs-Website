import subprocess
import json

# Define repositories and corresponding keys for replacement
repositories = {
    "danielpinhas/flask-k8s": "flask1",
    "danielpinhas/flask2-k8s": "flask2",
    "danielpinhas/flask3-k8s": "flask3"
}

# Fetch and update the tags for each repository
for repository, key in repositories.items():
    response = subprocess.run(["curl", "-s", f"https://registry.hub.docker.com/v2/repositories/{repository}/tags/"], stdout=subprocess.PIPE)
    response_json = response.stdout.decode("utf-8")
    available_versions = [tag["name"] for tag in json.loads(response_json)["results"]]

    if available_versions:
        latest_version = max(available_versions)

        # Replace the tag in the values.yml file
        subprocess.run(["sed", "-i", f"s/{key}:\s*tag:\s*.*/{key}:\n  image:\n    repository: {repository}\n    tag: {latest_version}/", "values.yml"])
        print(f"Updated {key} tag to {latest_version}")
    else:
        print(f"No available versions for {repository}")
