#!/bin/bash

# Color variables
RED='\033[0;31m'   # Red colored text
NC='\033[0m'       # Normal text
YELLOW='\033[33m'  # Yellow Color

echo -e "${YELLOW}--- GoDaddy Management Script ---${NC}"

# Enter API credentials
read -p "Enter your API key: " API_KEY
read -p "Enter your API secret: " API_SECRET

wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O jq
chmod +x jq
sudo mv jq /usr/local/bin

while true; do
    echo -e "${YELLOW}--- Select an action ---${NC}"
    echo "0) Exit"
    echo "1) Check domain availability"
    echo "2) Create DNS record"
    echo "3) Update DNS record"
    echo "4) Delete DNS record"
    echo "5) List all DNS A records"
    read -p "Enter your choice: " choice

    case $choice in
        0)
            echo "Exiting script."
            exit;;
        1)
            echo -e "${YELLOW}--- Check Domain Availability for purchase ---${NC}"
            read -p "Enter the domain name to check: " Domain_Name

            # Calling the GoDaddy API to check domain availability
            response=$(curl -s -X GET \
                -H "Authorization: sso-key $API_KEY:$API_SECRET" \
                "https://api.godaddy.com/v1/domains/available?domain=$Domain_Name")

            available=$(echo "$response" | jq -r '.available')
            if [ "$available" = "true" ]; then
                echo "Domain $Domain_Name is available for purchase."
            else
                echo "Domain $Domain_Name is not available for purchase."
            fi
            ;;
        2)
            echo -e "${YELLOW}--- Create DNS Record ---${NC}"
            read -p "Enter the type of record (e.g., A, MX, SRV): " Record_Type
            read -p "Enter the domain name: " Domain_Name
            read -p "Enter the name: " Name
            read -p "Enter the IP address/data: " Data
            read -p "Enter the TTL (time-to-live): " TTL

            # Construct the JSON payload based on the provided fields
            payload="{\"data\": \"$Data\", \"name\": \"$Name\", \"ttl\": $TTL, \"type\": \"$Record_Type\"}"

            # Calling the GoDaddy API to create a DNS record
            response=$(curl -s -X PATCH \
                -H "Authorization: sso-key $API_KEY:$API_SECRET" \
                -H "Content-Type: application/json" \
                -d "[$payload]" \
                "https://api.godaddy.com/v1/domains/$Domain_Name/records")

            # Check if the request was successful
            if [ "$(echo "$response" | jq -r '.code')" = "OK" ]; then
                echo "DNS record created successfully."
            else
                echo "Error: $(echo "$response" | jq -r '.message')"
            fi
            ;;
        3)
            echo -e "${YELLOW}--- Update DNS Record ---${NC}"
            read -p "Enter the domain name: " Domain_Name
            read -p "Enter the name: " Name
            read -p "Enter the new IP address/data: " Data
            read -p "Enter the new TTL (time-to-live): " TTL

            # Construct the JSON payload based on the provided fields
            payload="{\"data\": \"$Data\", \"ttl\": $TTL }"

            # Calling the GoDaddy API to update a DNS record
            response=$(curl -s -X PATCH \
                -H "Authorization: sso-key $API_KEY:$API_SECRET" \
                -H "Content-Type: application/json" \
                -d "[$payload]" \
                "https://api.godaddy.com/v1/domains/$Domain_Name/records/A/$Name")

            # Check if the request was successful
            if [ "$(echo "$response" | jq -r '.code')" = "OK" ]; then
                echo "DNS record updated successfully."
            else
                echo "Error: $(echo "$response" | jq -r '.message')"
            fi
            ;;
        4)
            echo -e "${YELLOW}--- Delete DNS Record ---${NC}"
            read -p "Enter the domain name: " Domain_Name
            read -p "Enter the name: " Name

            # Calling the GoDaddy API to delete a DNS record
            response=$(curl -s -X DELETE \
                -H "Authorization: sso-key $API_KEY:$API_SECRET" \
                "https://api.godaddy.com/v1/domains/$Domain_Name/records/A/$Name")

            # Check if the request was successful
            if [ "$(echo "$response" | jq -r '.code')" = "OK" ]; then
                echo "DNS record deleted successfully."
            else
                echo "Error: $(echo "$response" | jq -r '.message')"
            fi
            ;;
        5)
            echo -e "${YELLOW}--- List all DNS A records ---${NC}"

            # Calling the GoDaddy API to list all DNS A records
            response=$(curl -s -X GET \
                -H "Authorization: sso-key $API_KEY:$API_SECRET" \
                "https://api.godaddy.com/v1/domains/mnserviceproviders.com/records/A")

            # Displaying the response
            echo "$response" | jq
            ;;
        *)
            echo -e "${RED}Invalid choice. Please enter a valid option.${NC}"
            ;;
    esac
done
