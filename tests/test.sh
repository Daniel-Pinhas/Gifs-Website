#!/bin/bash

# Define the Flask application URLs
IPflask1='http://FLASK_IP_PLACEHOLDER_1'
IPflask2='http://FLASK_IP_PLACEHOLDER_2'
IPflask3='http://FLASK_IP_PLACEHOLDER_3'
IPtest='http://FLASK_IP_PLACEHOLDER_PROD'


# Define the Flask application URL

sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://$IPtest")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi

sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http:///$IPflask1")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi

sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://$IPflask2")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi

sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://$IPflask3")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi