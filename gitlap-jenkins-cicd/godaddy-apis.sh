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
            curl -s -X GET -H "Authorization: sso-key A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7:3yFX8ZB5D71dT5J9D3Fpz5"  "https://api.godaddy.com/v1/domains/mnserviceproviders.com/records/A"

            echo -e "${YELLOW}--- Create DNS Record ---${NC}"
            read -p "Enter the type of record (e.g., A, MX, SRV): " Record_Type
            read -p "Enter the domain name: " Domain_Name
            read -p "Enter the name: " Name
            read -p "Enter the IP address/data: " Data
            read -p "Enter the TTL (time-to-live): " TTL

            # Construct the JSON payload based on the provided fields
            payload="{\"type\": \"$Record_Type\", \"name\": \"$Name\", \"data\": \"$Data\", \"ttl\": $TTL }"

            # Prompt for additional fields based on the record type
            case $Record_Type in
                "MX" | "SRV")
                    read -p "Enter the priority: " Priority
                    payload="$payload, \"priority\": $Priority"
                    ;;
                "SRV")
                    read -p "Enter the service: " Service
                    read -p "Enter the protocol: " Protocol
                    read -p "Enter the port: " Port
                    read -p "Enter the weight: " Weight
                    payload="$payload, \"service\": \"$Service\", \"protocol\": \"$Protocol\", \"port\": $Port, \"weight\": $Weight"
                    ;;
            esac

            payload="$payload }"

            # Calling the GoDaddy API to create a DNS record
            response=$(curl -s -X POST \
                -H "Authorization: sso-key $API_KEY:$API_SECRET" \
                -H "Content-Type: application/json" \
                -d "$payload" \
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
            read -p "Enter the type of record (e.g., A, MX, SRV): " Record_Type
            read -p "Enter the domain name: " Domain_Name
            read -p "Enter the name: " Name
            read -p "Enter the new IP address/data: " Data
            read -p "Enter the new TTL (time-to-live): " TTL

            # Construct the JSON payload based on the provided fields
            payload="{\"data\": \"$Data\", \"ttl\": $TTL }"

            # Calling the GoDaddy API to update a DNS record
            response=$( curl -X PUT \
                -H "Authorization: sso-key A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7:3yFX8ZB5D71dT5J9D3Fpz5" \
                -H "Content-Type: application/json" \
                -d '{"records":[{"data": "3.84.100.41"}]}' \
                "https://api.godaddy.com/v1/domains/mnserviceproviders.com/records/A/www.sr7")


            # Check if the request was successful
            if [ "$(echo "$response" | jq -r '.code')" = "OK" ]; then
                echo "DNS record updated successfully."
            else
                echo "Error: $(echo "$response" | jq -r '.message')"
            fi
            ;;
        4)
            echo -e "${YELLOW}--- Delete DNS Record ---${NC}"
            read -p "Enter the type of record (e.g., A, MX, SRV): " Record_Type
            read -p "Enter the domain name: " Domain_Name
            read -p "Enter the name: " Name

            # Calling the GoDaddy API to delete a DNS record
            response=$(curl -s -X DELETE \
                -H "Authorization: sso-key $API_KEY:$API_SECRET" \
                -H "Content-Type: application/json" \
                "https://api.godaddy.com/v1/domains/$Domain_Name/records/$Record_Type/$Name")

            # Check if the request was successful
            if [ "$(echo "$response" | jq -r '.code')" = "OK" ]; then
                echo "DNS record deleted successfully."
            else
                echo "Error: $(echo "$response" | jq -r '.message')"
            fi
            ;;
        *)
            echo -e "${RED}Invalid choice. Please enter a valid option.${NC}"
            ;;
    esac
done

#A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7
#3yFX8ZB5D71dT5J9D3Fpz5

Correct APIs are below

# listing all the A type record names under mnserviceproviders.com

curl -s -X GET -H "Authorization: sso-key A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7:3yFX8ZB5D71dT5J9D3Fpz5"  "https://api.godaddy.com/v1/domains/mnserviceproviders.com/records/A"


#updating dns record

curl -X PATCH \
  -H "Authorization: sso-key A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7:3yFX8ZB5D71dT5J9D3Fpz5" \
  -H "Content-Type: application/json" \
  -d '[
        {
          "data": "49.205.217.10",
          "name": "scr",
          "ttl": 600,
          "type": "A"
        }
      ]' \
  "https://api.godaddy.com/v1/domains/mnsp.co.in/records/"



#creating the DNS record
curl -X PATCH   -H "Authorization: sso-key A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7:3yFX8ZB5D71dT5J9D3Fpz5"   -H "Content-Type: application/json"   -d '[{"data": "54.88.73.27", "name": "www", "ttl": 3600, "type": "A"}]'   "https://api.godaddy.com/v1/domains/mnserviceproviders.com/records"
curl -X PATCH   -H "Authorization: sso-key A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7:3yFX8ZB5D71dT5J9D3Fpz5"   -H "Content-Type: application/json"   -d '[{"data": "3.80.136.249", "name": "saru", "ttl": 3600, "type": "A"}]'   "https://api.godaddy.com/v1/domains/mnserviceproviders.com/records"

#deleting a DNS record

curl -X DELETE \
  -H "Authorization: sso-key A535dqnbBHF_DnvzSwqRvYCkW5HdBwVaS7:3yFX8ZB5D71dT5J9D3Fpz5" \
  -H "Content-Type: application/json" \
  "https://api.godaddy.com/v1/domains/mnsp.co.in/records/A/sourcecode"

