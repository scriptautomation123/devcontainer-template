#!/bin/bash

# Check for required environment variables
echo "Validating required environment variables..."

missing_vars=()

if [ -z "${ORA_PWD}" ]; then
    missing_vars+=("ORA_PWD")
fi

if [ -z "${VAULT_DEV_ROOT_TOKEN_ID}" ]; then
    missing_vars+=("VAULT_DEV_ROOT_TOKEN_ID")
fi

if [ ${#missing_vars[@]} -ne 0 ]; then
    echo "❌ ERROR: Missing required environment variables:"
    for var in "${missing_vars[@]}"; do
        echo "  - $var"
    done
    echo ""
    echo "Please set these environment variables in your Codespaces secrets:"
    echo "1. Go to your GitHub repository"
    echo "2. Click Settings > Secrets and variables > Codespaces"
    echo "3. Add the missing secrets"
    echo ""
    exit 1
fi

echo "✅ All required environment variables are set!"
exit 0