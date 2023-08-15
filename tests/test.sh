#!/bin/bash

# Define the Flask application URLs
IPflask1='http://FLASK_IP_PLACEHOLDER_1:5000'
IPflask2='http://FLASK_IP_PLACEHOLDER_2:5000'
IPflask3='http://FLASK_IP_PLACEHOLDER_3:5000'
IPtest='http://FLASK_IP_PLACEHOLDER_PROD'


# Define the Flask application URL
FLASK_URL="http://35.239.208.149"
sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://35.239.208.149")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi

FLASK_URL="http://34.31.106.119:5000"
sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://34.31.106.119:5000")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi

FLASK_URL="http://34.170.154.176:5000"
sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://34.170.154.176:5000")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi

FLASK_URL="http://35.224.239.186:5000"
sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://35.224.239.186:5000")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi