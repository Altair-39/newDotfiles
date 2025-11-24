#!/bin/bash

LOCATION="Turin"

# Fetch the data with minimal spacing
DATA=$(curl -s "https://wttr.in/$LOCATION?format=%c+%t")

# Trim extra spaces just in case
OUTPUT=$(echo "$DATA" | tr -s ' ')

# Print the output
echo -n "$OUTPUT"

