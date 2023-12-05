#!/bin/bash

# Retrieve AWS S3 bucket name from environment variable
S3_BUCKET_NAME="${AWS_S3_BUCKET_NAME}"

# Retrieve database configuration from environment variables
DATABASE_NAME="${MYSQL_DATABASE}"
DATABASE_USER="${MYSQL_USER}"
DATABASE_PASSWORD="${MYSQL_PASSWORD}"
DATABASE_HOST="${MYSQL_HOST}"

# Check if all required environment variables are set
if [ -z "$S3_BUCKET_NAME" ] || [ -z "$DATABASE_NAME" ] || [ -z "$DATABASE_USER" ] || [ -z "$DATABASE_PASSWORD" ] || [ -z "$DATABASE_HOST" ]; then
    echo "Environment variables (AWS_S3_BUCKET_NAME, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, MYSQL_HOST) must be set."
    exit 1
fi

# Function to backup the database and upload to S3
backup_database() {
    echo "Starting database backup..."
    DUMP_FILE="${DATABASE_NAME}_$(date +%Y%m%d_%H%M%S).sql"

    # Create a database dump
    mysqldump -h $DATABASE_HOST -u $DATABASE_USER -p$DATABASE_PASSWORD $DATABASE_NAME > $DUMP_FILE

    # Upload to S3
    aws s3 cp $DUMP_FILE s3://$S3_BUCKET_NAME/$DUMP_FILE

    # Clean up the dump file
    rm $DUMP_FILE
    echo "Database backup completed and uploaded to S3."
}

# Function to restore the database from an S3 backup
restore_database() {
    BACKUP_FILE=$1

    if [ -z "$BACKUP_FILE" ]; then
        echo "Backup file name required for restoration."
        exit 1
    fi

    echo "Starting database restoration..."

    # Download backup from S3
    aws s3 cp s3://$S3_BUCKET_NAME/$BACKUP_FILE $BACKUP_FILE

    # Restore database
    mysql -h $DATABASE_HOST -u $DATABASE_USER -p$DATABASE_PASSWORD $DATABASE_NAME < $BACKUP_FILE

    # Clean up the downloaded file
    rm $BACKUP_FILE
    echo "Database restoration completed."
}

# Main script logic
case "$1" in
    backup)
        backup_database
        ;;
    restore)
        restore_database $2
        ;;
    *)
        echo "Usage: $0 {backup|restore} [backup-file-for-restore]"
        exit 1
        ;;
esac
