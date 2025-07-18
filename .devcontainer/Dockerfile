# Create this file at: .devcontainer/Dockerfile
FROM mcr.microsoft.com/devcontainers/java:1-21-bullseye

# Install additional tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Install Oracle Instant Client (for sqlplus)
RUN wget -q https://download.oracle.com/otn_software/linux/instantclient/2112000/instantclient-basic-linux.x64-21.12.0.0.0dbru.zip \
    && wget -q https://download.oracle.com/otn_software/linux/instantclient/2112000/instantclient-sqlplus-linux.x64-21.12.0.0.0dbru.zip \
    && unzip instantclient-basic-linux.x64-21.12.0.0.0dbru.zip \
    && unzip instantclient-sqlplus-linux.x64-21.12.0.0.0dbru.zip \
    && mv instantclient_21_12 /opt/oracle \
    && rm -f instantclient-*.zip

# Set Oracle environment variables
ENV ORACLE_HOME=/opt/oracle
ENV LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
ENV PATH=$ORACLE_HOME:$PATH

# Install Vault CLI
RUN wget -q https://releases.hashicorp.com/vault/1.15.2/vault_1.15.2_linux_amd64.zip \
    && unzip vault_1.15.2_linux_amd64.zip \
    && mv vault /usr/local/bin/ \
    && rm vault_1.15.2_linux_amd64.zip

USER vscode