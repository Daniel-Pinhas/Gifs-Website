import subprocess

# Get the Ingress IPs
ingress_ips = subprocess.check_output(["kubectl", "describe", "service"]).decode("utf-8")
ingress_ips = [line.split()[2] for line in ingress_ips.splitlines() if "LoadBalancer Ingress:" in line]

# Use a placeholder to represent the Flask IP in the config.yml file
# The placeholder can be any unique string that doesn't appear elsewhere in the file
placeholder_1 = "__FLASK_IP_PLACEHOLDER_1__"
placeholder_2 = "__FLASK_IP_PLACEHOLDER_2__"
placeholder_3 = "__FLASK_IP_PLACEHOLDER_3__"

config_path = "template/config.yml"  # Adjust this path as needed

# Replace the Flask IPs in the config.yml file with the Ingress IPs
with open(config_path, "r") as f:
    content = f.read()

content = content.replace(f"http://{placeholder_1}:5000", f"http://{ingress_ips[0]}:5000")
content = content.replace(f"http://{placeholder_2}:5000", f"http://{ingress_ips[1]}:5000")
content = content.replace(f"http://{placeholder_3}:5000", f"http://{ingress_ips[2]}:5000")

with open(config_path, "w") as f:
    f.write(content)

print("Ingress IPs inserted in config.yml successfully.")
