#!/bin/bash

# Usage function
usage() {
    echo "Usage: $0 -d domain -f subdomains-file [-l logfile]"
    exit 1
}

# ASCII banner
banner() {
echo "▓█████▄  ██▓  ██████  ▄████▄   ▒█████   ▒█████   ▒█████  "
echo "▒██▀ ██▌▓██▒▒██    ▒ ▒██▀ ▀█  ▒██▒  ██▒▒██▒  ██▒▒██▒  ██▒"
echo "░██   █▌▒██▒░ ▓██▄   ▒▓█    ▄ ▒██░  ██▒▒██░  ██▒▒██░  ██▒"
echo "░▓█▄   ▌░██░  ▒   ██▒▒▓▓▄ ▄██▒▒██   ██░▒██   ██░▒██   ██░"
echo "░▒████▓ ░██░▒██████▒▒▒ ▓███▀ ░░ ████▓▒░░ ████▓▒░░ ████▓▒░"
echo " ▒▒▓  ▒ ░▓  ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░▒░▒░ ░ ▒░▒░▒░ "
echo " ░ ▒  ▒  ▒ ░░ ░▒  ░ ░  ░  ▒     ░ ▒ ▒░   ░ ▒ ▒░   ░ ▒ ▒░ "
echo " ░ ░  ░  ▒ ░░  ░  ░  ░        ░ ░ ░ ▒  ░ ░ ░ ▒  ░ ░ ░ ▒  "
echo "   ░     ░        ░  ░ ░          ░ ░      ░ ░      ░ ░  "
echo " ░                   ░                                    "

    echo "Usage: $0 -d domain -f subdomains-file [-l logfile]"
}

# Parse command-line arguments
logfile=""
while getopts ":d:f:l:" opt; do
    case $opt in
        d) domain=$OPTARG ;;
        f) file=$OPTARG ;;
        l) logfile=$OPTARG ;;
        *) usage ;;
    esac
done

# Ensure domain and file parameters are provided
if [ -z "$domain" ] || [ -z "$file" ]; then
    usage
fi

# Check if file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found!"
    exit 1
fi

# Function to log output
log() {
    if [ -n "$logfile" ]; then
        echo "$1" >> "$logfile"
    else
        echo "$1"
    fi
}

# Function to resolve IP and check services
resolve_and_check() {
    subdomain=$1
    fqdn="${subdomain}.${domain}"

    # Resolve IP address
    ip=$(dig +short "$fqdn")
    if [ -z "$ip" ]; then
        log "[ERROR] Unable to resolve IP for $fqdn"
        return
    fi

    # Verify reverse resolution
    reverse_name=$(dig +short -x "$ip")
    if [ -z "$reverse_name" ]; then
        log "[WARNING] Reverse resolution failed for $ip"
    fi

    # Curl the resolved IP
    curl_result=$(curl -s -o /dev/null -w "%{http_code}" "http://$ip")
    
    # Nmap scan for ports 80 and 443
    nmap_result=$(nmap -p 80,443 "$ip" | grep -E "80/tcp|443/tcp")

    # Output the results
    log "========================================"
    log "Subdomain: $subdomain"
    log "FQDN: $fqdn"
    log "Resolved IP: $ip"
    log "Reverse Name: $reverse_name"
    log "Curl HTTP Code: $curl_result"
    log "Nmap Results:"
    log "$nmap_result"
    log "========================================"
}

# Display banner
banner

# Clear log file if it exists
if [ -n "$logfile" ]; then
    > "$logfile"
fi

# Process each subdomain in the file
while IFS= read -r subdomain; do
    resolve_and_check "$subdomain"
done < "$file"

