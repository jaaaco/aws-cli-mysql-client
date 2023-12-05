# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install AWS CLI
RUN pip install --no-cache-dir awscli

# Install MySQL client
RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

# Copy the backup/restore script into the container
# Note: You should create this script according to your backup/restore logic.
COPY backup_restore_script.sh .
RUN chmod +x backup_restore_script.sh

# Set the script as the entrypoint
ENTRYPOINT ["./backup_restore_script.sh"]
