import subprocess

# Get the Ingress IPs
ingress_ips = subprocess.check_output(["kubectl", "describe", "service"]).decode("utf-8")
ingress_ips = [line.split()[2] for line in ingress_ips.splitlines() if "LoadBalancer Ingress:" in line]

placeholder_1 = "__FLASK_IP_PLACEHOLDER_1__"
placeholder_2 = "__FLASK_IP_PLACEHOLDER_2__"
placeholder_3 = "__FLASK_IP_PLACEHOLDER_3__"

config_path = "config.yml"  

with open(config_path, "r") as f:
    content = f.read()

content = content.replace(f"http://{placeholder_1}:80", f"http://{ingress_ips[0]}:80")
content = content.replace(f"http://{placeholder_2}:80", f"http://{ingress_ips[1]}:80")
content = content.replace(f"http://{placeholder_3}:80", f"http://{ingress_ips[2]}:80")

with open(config_path, "w") as f:
    f.write(content)

print("Ingress IPs inserted in config.yml successfully.")
