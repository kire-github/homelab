#!/bin/bash

USERNAME="<DOMAIN>"
KEY="<API_KEY>"
IP_CACHE="/tmp/ddns_ip_cache.txt"

echo "Beginning ddns update"

CURRENT_IP=$(curl api.ipify.org)

echo "Got current IP"

if [ -f "$IP_CACHE" ]; then
    CACHED_IP=$(cat "$IP_CACHE")
fi

echo "Retrieved cached IP"

if [ "$CURRENT_IP" != "$CACHED_IP" ]; then
    RESPONSE=$(curl -v "https://update.dedyn.io/nic/update?system=dyndns&hostname=$USERNAME&myip=$CURRENT_IP" -u "$USERNAME:$KEY")
    if [[ $RESPONSE == *'good'* ]]; then
        echo "$CURRENT_IP" > "$IP_CACHE"
        echo "IP updated to $CURRENT_IP"
    else
        echo "Failed to update IP: $RESPONSE"
    fi
else
    echo "IP has not changed."
fi
