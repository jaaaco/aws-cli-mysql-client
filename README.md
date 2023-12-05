# MySQL Backup and Restore Script for Kubernetes

This repository contains the `backup_restore_script.sh`, a shell script designed to facilitate the backup and restoration of MySQL databases in Kubernetes environments using AWS S3 for storage.

## Overview

The `backup_restore_script.sh` script automates the process of backing up MySQL databases to an AWS S3 bucket and restoring them from there. It uses AWS CLI for S3 interactions and the MySQL client for database operations.

## Prerequisites

- AWS CLI installed and configured with the necessary permissions to access the S3 bucket.
- MySQL client installed for interacting with the MySQL database.
- Access to a MySQL database with the necessary permissions to perform backups and restores.
- An AWS S3 bucket for storing the database backups.

## Configuration

Set the following environment variables for the script to function correctly:

- `AWS_S3_BUCKET_NAME`: The name of your AWS S3 bucket.
- `MYSQL_DATABASE`: The name of your MySQL database.
- `MYSQL_USER`: The username for your MySQL database.
- `MYSQL_PASSWORD`: The password for your MySQL database.
- `MYSQL_HOST`: The hostname or IP address of your MySQL database server.

## Usage

### Backing Up a Database

To perform a backup, run the script with the `backup` argument:

```bash
./backup_restore_script.sh backup
```

This command will create a backup of the MySQL database and upload it to the specified S3 bucket.

### Restoring a Database

To restore a database, run the script with the restore argument followed by the name of the backup file:

```bash
./backup_restore_script.sh restore [backup-file-name]
```

Replace [backup-file-name] with the actual name of the backup file you wish to restore from.

## Additional Notes

Ensure that the script has executable permissions: chmod +x backup_restore_script.sh.
It is highly recommended to test the script in a non-production environment before using it in production.
The script does not include advanced error handling or logging. Modify and enhance it as per your requirements.

## Contributing

Contributions to enhance the functionality of this script are welcome. Please adhere to standard coding practices and provide documentation for your changes.
