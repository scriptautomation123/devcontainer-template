#!/bin/bash

echo "Starting Oracle and Vault setup..."

# Wait for Oracle to be ready
echo "Waiting for Oracle to be ready..."
until docker exec oracle-db sqlplus -L sys/${ORA_PWD}@//localhost:1521/XE as sysdba <<< "exit" >/dev/null 2>&1; do
  echo "Oracle is starting up... please wait"
  sleep 30
done
echo "Oracle Database is ready!"

# Wait for Vault to be ready
echo "Waiting for Vault to be ready..."
until curl -f http://localhost:8200/v1/sys/health >/dev/null 2>&1; do
  echo "Vault is starting up... please wait"
  sleep 5
done
echo "Vault is ready!"

# Configure Vault
echo "Configuring Vault..."
export VAULT_ADDR="http://localhost:8200"
export VAULT_TOKEN="${VAULT_DEV_ROOT_TOKEN_ID}"

# Enable database secrets engine
vault secrets enable database

# Configure Oracle database connection
vault write database/config/oracle-db \
    plugin_name="oracle-database-plugin" \
    connection_url="oracle://sys:${ORA_PWD}@localhost:1521/XE?as=sysdba" \
    allowed_roles="oracle-role"

# Create a role for Oracle
vault write database/roles/oracle-role \
    db_name="oracle-db" \
    creation_statements="CREATE USER \"{{name}}\" IDENTIFIED BY \"{{password}}\"; GRANT CONNECT TO \"{{name}}\"; GRANT CREATE SESSION TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"

echo "Setup complete!"
echo "================================"
echo "Oracle Database: localhost:1521"
echo "Vault: http://localhost:8200"
echo "Mock LDAP 1: localhost:1389"
echo "Mock LDAP 2: localhost:1390"
echo "Mock LDAP 3: localhost:1391"
echo "PlantUML: http://localhost:8080"
echo "================================"
