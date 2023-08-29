#!/bin/bash

# Define the Flask application URLs
IPflask1='__FLASK_IP_PLACEHOLDER_1__:80'
IPflask2='__FLASK_IP_PLACEHOLDER_2__:80'
IPflask3='__FLASK_IP_PLACEHOLDER_3__:80'
IPtest='__FLASK_IP_PLACEHOLDER_TEST__:80'


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

FLASK_URL=IPflask1
sleep 10
# Make a GET request to the Flask application
response=$(curl -s -o /dev/null -w "%{http_code}" "http://$IPflask1")

# Check the HTTP response code
if [ "$response" == "200" ]; then
    echo "Flask application is running successfully."
else
    echo "Flask application is not running. HTTP response code: $response"
    exit 1
fi

FLASK_URL=IPflask2
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

FLASK_URL=IPflask3
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