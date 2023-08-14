#!/bin/bash

# Get the Ingress IPs
ingress_ips=($(kubectl describe service | grep 'LoadBalancer Ingress:' | awk '{print $3}'))

# Replace the placeholders with the Ingress IPs in the YAML file
sed -i "s|__FLASK_IP_PLACEHOLDER_1__|http://${ingress_ips[0]}:5000|g" your-yaml-file.yaml
sed -i "s|__FLASK_IP_PLACEHOLDER_2__|http://${ingress_ips[1]}:5000|g" your-yaml-file.yaml
sed -i "s|__FLASK_IP_PLACEHOLDER_3__|http://${ingress_ips[2]}:5000|g" your-yaml-file.yaml

echo "Ingress IPs replaced in the YAML file successfully."
