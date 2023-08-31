#!/bin/bash

# Get the Ingress IPs
ingress_ips=($(kubectl describe service | grep Ingress | awk '{print $3}'))

# Define the Flask application URLs with placeholders
IPflask1='http://FLASK_IP_PLACEHOLDER_1'
IPflask2='http://FLASK_IP_PLACEHOLDER_2'
IPflask3='http://FLASK_IP_PLACEHOLDER_3'
IPprod='http://FLASK_IP_PLACEHOLDER_PROD'

# Replace the placeholders with the corresponding Ingress IPs
sed -i "s|http://FLASK_IP_PLACEHOLDER_1|${ingress_ips[0]}|g" prod.sh
sed -i "s|http://FLASK_IP_PLACEHOLDER_2|${ingress_ips[1]}|g" prod.sh
sed -i "s|http://FLASK_IP_PLACEHOLDER_3|${ingress_ips[2]}|g" prod.sh
sed -i "s|http://FLASK_IP_PLACEHOLDER_PROD|${ingress_ips[3]}|g" prod.sh

echo "Flask application URLs updated successfully."

