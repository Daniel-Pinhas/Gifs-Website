import os
import yaml
from google.cloud import storage

# Define your GCS bucket and chart name
bucket_name = "gifs-website-charts"
chart_name = "gifs-website"

# Create a GCS client
client = storage.Client()

# Get the list of objects in the bucket
bucket = client.get_bucket(bucket_name)
blobs = list(bucket.list_blobs())

# Extract the versions from the chart names
versions = [blob.name.split(f"{chart_name}-")[1].replace('.tgz', '') for blob in blobs if blob.name.startswith(f"{chart_name}-")]

# Ensure versions are integers
versions = [tuple(map(int, version.split('.'))) for version in versions]

# Find the latest version
latest_version = max(versions)

# Apply the version incrementing logic
major, minor, patch = latest_version
patch += 1
if patch == 10:
    minor += 1
    patch = 0
    if minor == 10:
        major += 1
        minor = 0

# Convert the latest version back to string format
latest_version_str = '.'.join(map(str, (major, minor, patch)))

# Define the path to your Chart.yaml file
chart_yaml_path = "charts-test/Chart.yaml"

# Read the YAML file
with open(chart_yaml_path, "r") as f:
    chart_yaml = yaml.safe_load(f)

# Update the version in the dictionary
chart_yaml["version"] = latest_version_str

# Write the updated YAML back to the file
with open(chart_yaml_path, "w") as f:
    yaml.dump(chart_yaml, f, default_flow_style=False)

# Print the updated version
print(f"Updated Version: {latest_version_str}")

# Export the updated version as a GitHub environment variable
os.environ["Updated-Version"] = latest_version_str
