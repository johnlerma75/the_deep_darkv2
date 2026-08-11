#!/bin/bash
# Script to inject Firebase API key into index.html
# Usage: ./scripts/inject-secrets.sh <api-key>

if [ -z "$1" ]; then
    echo "Error: Firebase API key not provided"
    echo "Usage: $0 <firebase-api-key>"
    exit 1
fi

API_KEY="$1"
FILE="index.html"

if [ ! -f "$FILE" ]; then
    echo "Error: $FILE not found"
    exit 1
fi

# Use sed to replace the placeholder with the actual API key
ESCAPED_KEY=$(printf '%s\n' "$API_KEY" | sed -e 's/[\/&]/\\&/g')

# macOS uses different sed syntax; try both
if sed --version 2>/dev/null | grep -q GNU; then
    # GNU sed
    sed -i "s/PLACE_HOLDER_GIT_SECRETS/$ESCAPED_KEY/g" "$FILE"
else
    # BSD sed (macOS)
    sed -i '' "s/PLACE_HOLDER_GIT_SECRETS/$ESCAPED_KEY/g" "$FILE"
fi

echo "✓ Firebase API key injected successfully"
