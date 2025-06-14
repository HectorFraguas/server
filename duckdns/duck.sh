#!/bin/bash

echo "Actualizando IP para DuckDNS..."
url="https://www.duckdns.org/update?domains=${DUCKDNS_DOMAIN}&token=${DUCKDNS_TOKEN}&ip="
curl -k -s "$url"
