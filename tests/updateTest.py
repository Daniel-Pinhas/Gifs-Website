import subprocess
import re

# Get the Ingress IPs
ingress_ips_output = subprocess.check_output(["kubectl", "get", "service", "--output=json"]).decode("utf-8")
ingress_ips = re.findall(r"\"ingress\"\:\[.*?\"ip\"\:\"(.*?)\"", ingress_ips_output)

placeholders = ["__FLASK_IP_PLACEHOLDER_1__", "__FLASK_IP_PLACEHOLDER_2__", "__FLASK_IP_PLACEHOLDER_3__", "__FLASK_IP_PLACEHOLDER_4__"]
config_path = "test.sh"

with open(config_path, "r") as f:
    content = f.read()

for i, placeholder in enumerate(placeholders):
    if i < len(ingress_ips):
        content = content.replace(f"http://{placeholder}:80", f"http://{ingress_ips[i]}:80")

with open(config_path, "w") as f:
    f.write(content)

print("Ingress IPs inserted in test.sh successfully.")
