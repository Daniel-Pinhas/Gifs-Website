file_path = "helm-chart/values.yml"
lines_to_delete = ["  user_name:", "  user_pwd:"]

# Read the file
with open(file_path, "r") as file:
    lines = file.readlines()

# Remove the specified lines
new_lines = [line for line in lines if not any(line.strip().startswith(pattern) for pattern in lines_to_delete)]

# Write the updated content back to the file
with open(file_path, "w") as file:
    file.writelines(new_lines)
