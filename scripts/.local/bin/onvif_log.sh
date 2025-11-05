#!/bin/bash

# ONVIF Logging Script
# Logs incoming ONVIF connections to system log if logging is enabled

LOG_ENABLE_FILE="/root/Data/log_en.txt"
SYSTEM_LOG_FILE="/root/log/system.log"

# Function to check if logging is enabled
is_logging_enabled() {
    if [ -f "$LOG_ENABLE_FILE" ]; then
        local content
        content=$(tr -d '[:space:]' < "$LOG_ENABLE_FILE")
        if [ "$content" = "1" ]; then
            return 0
        fi
    fi
    return 1
}

# Function to log ONVIF connection
log_onvif_connection() {
    local ip_address="$1"
    
    if [ -z "$ip_address" ]; then
        echo "Error: IP address not provided" >&2
        return 1
    fi
    
    # Check if logging is enabled
    if ! is_logging_enabled; then
        return 0
    fi
    
    # Create log directory if it doesn't exist
    local log_dir
    log_dir=$(dirname "$SYSTEM_LOG_FILE")
    if [ ! -d "$log_dir" ]; then
        mkdir -p "$log_dir"
        chmod 750 "$log_dir"
    fi
    
    # Get current timestamp in the specified format
    local timestamp
    timestamp=$(date +"%a %b %d %H:%M:%S %Z %Y")
    
    # Log the connection
    echo "ONVIF: Incoming connection from ($ip_address) at $timestamp" >> "$SYSTEM_LOG_FILE"
}

# Main execution
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <ip_address>"
    echo "Logs an ONVIF connection from the specified IP address"
    exit 1
fi

log_onvif_connection "$1"
