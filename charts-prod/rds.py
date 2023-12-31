import os
import yaml

chart_yaml_path = "charts-test/Chart.yaml" 

rds_creds = os.environ.get("RDS_CREDS")

# Read the file content
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
    
    # Print the updated version
    print(f"Updated Version: {chart_yaml['version']}")

    # Write the updated YAML back to the file
    with open(chart_yaml_path, "w") as f:
        yaml.dump(chart_yaml, f, default_flow_style=False)

else:
    print("Version field not found in Chart.yaml")


