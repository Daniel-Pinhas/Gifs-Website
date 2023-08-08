import docker
import subprocess
import json

client = docker.from_env()

# Fetch available versions using curl and jq
response = subprocess.run(["curl", "-s", "https://registry.hub.docker.com/v2/repositories/danielpinhas/flask-k8s/tags/"], stdout=subprocess.PIPE)
response_json = response.stdout.decode("utf-8")
print("Response JSON:", response_json)  # Add this line

available_versions = [tag["name"] for tag in json.loads(response_json)["results"]]
print("Available Versions:", available_versions)  # Add this line

if available_versions:
    existing_versions = [float(version.split(":")[1]) for version in available_versions if version.startswith("danielpinhas/flask-k8s:")]
    print("Existing Versions:", existing_versions)  # Add this line
    latest_version = max(existing_versions)
    next_version = latest_version + 0.1
else:
    next_version = 1.0

# Format the version number to one decimal place
next_version = f"{next_version:.1f}"
image_name = f"danielpinhas/flask-k8s:{next_version}"

# Build the new version image
client.images.build(path=".", tag=image_name, rm=True, pull=True)
print(f"Successfully built image: {image_name}")

# Push the image to Docker Hub
client.images.push(repository="danielpinhas/flask-k8s", tag=next_version)
print(f"Successfully pushed image: {image_name}")

# Tag the new version as "latest"
latest_image_name = "danielpinhas/flask-k8s:latest"
client.images.get(image_name).tag(latest_image_name)
print(f"Successfully tagged image as latest: {latest_image_name}")

# Push the latest image to Docker Hub
client.images.push(repository="danielpinhas/flask-k8s", tag="latest")
print(f"Successfully pushed latest image: {latest_image_name}")

# Remove the intermediate images without a tag
intermediate_images = [image for image in images if not image.tags]
for image in intermediate_images:
    client.images.remove(image=image.id, force=True)
    print(f"Successfully deleted intermediate image: {image.id}")

