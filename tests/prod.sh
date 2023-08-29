#!/bin/bash

# Define the Flask application URLs
FLASK_URL="__FLASK_IP_PLACEHOLDER_1__:80"
FLASK_URL="__FLASK_IP_PLACEHOLDER_2__:80"
FLASK_URL="__FLASK_IP_PLACEHOLDER_3__:80"
FLASK_URL="__FLASK_IP_PLACEHOLDER_4__:80"

# Define the sleep duration
SLEEP_DURATION=10

# Helper function to check Flask application status
check_flask_status() {
    sleep $SLEEP_DURATION
    response=$(curl -s -o /dev/null -w "%{http_code}" "$FLASK_URL")
    
    if [ "$response" == "200" ]; then
        echo "Flask application at $FLASK_URL is running successfully."
    else
        echo "Flask application at $FLASK_URL is not running. HTTP response code: $response"
        exit 1
    fi
}

# Check status for each Flask application
check_flask_status

FLASK_URL="__FLASK_IP_PLACEHOLDER_2__:80"
check_flask_status

FLASK_URL="__FLASK_IP_PLACEHOLDER_3__:80"
check_flask_status

FLASK_URL="__FLASK_IP_PLACEHOLDER_4__:80"
check_flask_status
