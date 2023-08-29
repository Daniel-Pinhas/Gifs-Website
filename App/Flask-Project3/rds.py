import os

rds_creds = os.environ.get("RDS_CREDS")

# Read the file content
with open("app.py", "r") as f:
    file_content = f.read()

# Replace placeholders with the secret value
file_content = file_content.replace("$DEV_RDS_CREDS_U", rds_creds)
file_content = file_content.replace("$DEV_RDS_CREDS_P", rds_creds)

# Write the modified content back to the file
with open("values.yml", "w") as f:
    f.write(file_content)