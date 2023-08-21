import sys
import re
import subprocess
import json
from packaging import version

if len(sys.argv) < 2:
    print("Usage: python3 changetag.py <repository_name>")
    sys.exit(1)

repository_name = sys.argv[1]

# Fetch available versions using curl and jq
response = subprocess.run(["curl", "-s", f"https://registry.hub.docker.com/v2/repositories/{repository_name}/tags/"], stdout=subprocess.PIPE)
response_json = response.stdout.decode("utf-8")
available_versions = [tag["name"] for tag in json.loads(response_json)["results"] if tag["name"] != "latest"]
existing_versions = [ver for ver in available_versions if not version.parse(ver).is_prerelease]
latest_version = str(max(existing_versions, key=version.parse))

# Read the content of the values.yaml file
with open("values.yml", "r") as f:
    content = f.read()

# Replace the tag placeholders with the latest version for the provided repository
repository_placeholder = repository_name.replace("/", "\\/")
pattern = rf"repository:\s+{repository_placeholder}\s+tag:\s+"
replacement = f"repository: {repository_name}\n    tag: {latest_version}\n"
content = re.sub(pattern, replacement, content)

# Write the updated content back to the values.yaml file
with open("values.yml", "w") as f:
    f.write(content)
