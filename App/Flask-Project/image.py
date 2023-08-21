import docker
import subprocess
import json

def get_available_versions():
    response = subprocess.run(["curl", "-s", "https://registry.hub.docker.com/v2/repositories/danielpinhas/flask-k8s/tags/"], stdout=subprocess.PIPE)
    response_json = response.stdout.decode("utf-8")
    available_versions = [tag["name"] for tag in json.loads(response_json)["results"]]
    return available_versions

def calculate_next_version(available_versions):
    existing_versions = [float(version) for version in available_versions if version.startswith("1.")]
    latest_version = max(existing_versions) if existing_versions else 1.0
    next_version = latest_version + 0.1
    return f"{next_version:.1f}"

def build_and_push_image(image_name, tag):
    client.images.build(path=".", tag=image_name, rm=True, pull=True)
    print(f"Successfully built image: {image_name}")
    
    client.images.push(repository="danielpinhas/flask-k8s", tag=tag)
    print(f"Successfully pushed image: {image_name}")

def tag_latest_version(image_name, latest_image_name):
    image = client.images.get(image_name)
    image.tag(latest_image_name)
    print(f"Successfully tagged image as latest: {latest_image_name}")

def remove_intermediate_images():
    images = client.images.list()
    intermediate_images = [image for image in images if not image.tags]
    for image in intermediate_images:
        try:
            client.images.remove(image=image.id, force=True)
            print(f"Successfully deleted intermediate image: {image.id}")
        except docker.errors.APIError as e:
            print(f"Error deleting intermediate image: {image.id}, {e}")

client = docker.from_env()

available_versions = get_available_versions()
next_version = calculate_next_version(available_versions)
image_name = f"danielpinhas/flask-k8s:{next_version}"

build_and_push_image(image_name, next_version)

latest_image_name = "danielpinhas/flask-k8s:latest"
tag_latest_version(image_name, latest_image_name)

client.images.push(repository="danielpinhas/flask-k8s", tag="latest")
print(f"Successfully pushed latest image: {latest_image_name}")

remove_intermediate_images()
