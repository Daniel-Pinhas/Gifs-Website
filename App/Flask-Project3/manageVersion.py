import docker
import subprocess
import json
import re

client = docker.from_env()

# Fetch available versions using curl and jq
response = subprocess.run(["curl", "-s", "https://registry.hub.docker.com/v2/repositories/danielpinhas/flask3-k8s/tags/"], stdout=subprocess.PIPE)
response_json = response.stdout.decode("utf-8")
available_versions = [tag["name"] for tag in json.loads(response_json)["results"]]

if available_versions:
    # Filter versions based on the repository name and extract the version part
    existing_versions = [float(version) for version in available_versions if re.match(r"^[1-9]\.", version)]
    latest_version = max(existing_versions)
    next_version = latest_version + 0.1
else:
    next_version = 1.0

# Format the version number to one decimal place
next_version = f"{next_version:.1f}"
image_name = f"danielpinhas/flask3-k8s:{next_version}"

# Build the new version image
client.images.build(path=".", tag=image_name, rm=True, pull=True)
print(f"Successfully built image: {image_name}")

# Push the image to Docker Hub
client.images.push(repository="danielpinhas/flask3-k8s", tag=next_version)
print(f"Successfully pushed image: {image_name}")

# Tag the new version as "latest"
latest_image_name = "danielpinhas/flask3-k8s:latest"
client.images.get(image_name).tag(latest_image_name)
print(f"Successfully tagged image as latest: {latest_image_name}")

# Push the latest image to Docker Hub
client.images.push(repository="danielpinhas/flask3-k8s", tag="latest")
print(f"Successfully pushed latest image: {latest_image_name}")

# Remove the intermediate images without a tag
images = client.images.list()
intermediate_images = [image for image in images if not image.tags]
for image in intermediate_images:
    client.images.remove(image=image.id, force=True)
    print(f"Successfully deleted intermediate image: {image.id}")