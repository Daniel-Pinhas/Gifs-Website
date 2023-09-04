import os
import yaml

# Define the path to your Chart.yaml file
chart_yaml_path = "charts-test/Chart.yaml"

# Read the YAML file
with open(chart_yaml_path, "r") as f:
    chart_yaml = yaml.safe_load(f)

# Extract the "version" field
if "version" in chart_yaml:
    version = chart_yaml["version"]
    # Split the version string into its components (major, minor, and patch)
    major, minor, patch = map(int, version.split('.'))
    
    # Check if the minor is 9 and patch is 9
    if minor == 9 and patch == 9:
        # If both are 9, increment the major, reset minor and patch to 0
        major += 1
        minor = 0
        patch = 0
    # Check if the minor is 9 but patch is not 9
    elif minor == 9:
        # If minor is 9 but patch is not, increment the minor and reset patch to 0
        minor += 1
        patch = 0
    else:
        # Otherwise, increment the patch
        patch += 1

    # Update the version in the dictionary
    chart_yaml["version"] = f"{major}.{minor}.{patch}"

    # Write the updated YAML back to the file
    with open(chart_yaml_path, "w") as f:
        yaml.dump(chart_yaml, f, default_flow_style=False)

    # Print the updated version
    updated_version = chart_yaml["version"]
    print(f"Updated Version: {updated_version}")

    # Export the updated version as an environment variable
    os.environ["Updated-Version"] = f"{updated_version}"

else:
    print("Version field not found in Chart.yaml")
