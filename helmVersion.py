import os
import yaml
from google.cloud import storage

# Define the path to your Chart.yaml file
chart_yaml_path = "charts-test/Chart.yaml"

# Initialize the Google Cloud Storage client
client = storage.Client()

# Define your GCS bucket and object prefix
bucket_name = 'gifs-website-charts'
object_prefix = 'charts/'

# List objects in the bucket
bucket = client.bucket(bucket_name)
blobs = bucket.list_blobs(prefix=object_prefix)

# Extract the version numbers from the object names
versions = []
for blob in blobs:
    version_str = blob.name.replace(object_prefix, '').replace('.tgz', '')
    versions.append(version_str)

# Find the latest version
latest_version = max(versions)

# Split the latest version string into its components (major, minor, and patch)
major, minor, patch = map(int, latest_version.split('.'))

# Increment the patch version, and if it reaches 10, increment the minor
# and reset patch to 0. If minor reaches 10, increment the major and reset minor to 0
patch += 1
if patch == 10:
    minor += 1
    patch = 0
    if minor == 10:
        major += 1
        minor = 0

# Update the version in the dictionary with the raised version
raised_version = f"{major}.{minor}.{patch}"

# Read the YAML file
with open(chart_yaml_path, "r") as f:
    chart_yaml = yaml.safe_load(f)

# Update the "version" field in the Chart.yaml with the raised version
chart_yaml["version"] = raised_version

# Write the updated YAML back to the file
with open(chart_yaml_path, "w") as f:
    yaml.dump(chart_yaml, f, default_flow_style=False)

# Print the updated version (without exporting)
print(f"Updated Version: {raised_version}")
