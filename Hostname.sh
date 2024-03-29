#!/bin/bash

# Function to extract hostname and agent from HTTP headers
extract_agent() {
    local file_name="$1"  # Pass the Wireshark file name as an argument

    # Use tshark to filter HTTP packets and extract hostnames
    tshark_output=$(tshark -r "$file_name" -Y "http.request" -T fields -e http.user_agent | sort -u)
    if [[ -n "$tshark_output" ]]; then
        echo "$tshark_output"  # Print the output
    else 
        echo "no http Traffic"
    fi
}

# Prompt the user to enter the Wireshark file name
read -p "Enter the Wireshark file name: " file_name

# Check if the file exists
if [ -f "$file_name" ]; then
    # Call the extract_hostname function and capture its output in a variable
    
    (extract_agent "$file_name")
    
else
    echo "File not found: $file_name"
fi
