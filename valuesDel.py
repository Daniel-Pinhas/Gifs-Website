import os

file_path = "helm-chart/values.yaml"
lines_to_delete = ["user_name:", "user_pwd:"]

# Check if the file exists
if os.path.isfile(file_path):
    with open(file_path, "r") as file:
        lines = file.readlines()

    # Remove the specified lines
    new_lines = [line for line in lines if not any(line.strip().startswith(pattern) for pattern in lines_to_delete)]

    # Write the updated content back to the file
    with open(file_path, "w") as file:
        file.writelines(new_lines)

    print("Lines removed successfully.")
else:
    print(f"File not found: {file_path}")
