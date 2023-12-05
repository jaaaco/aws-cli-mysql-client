This Docker image is specifically tailored for managing backups and restores in Kubernetes environments. It integrates the latest versions of AWS CLI and MySQL client, offering a robust and streamlined solution for handling database operations. The image is based on Python 3.9-slim, ensuring a lightweight yet functional base.

# Key Features

* AWS CLI: The AWS Command Line Interface is pre-installed, enabling direct interaction with AWS services. This feature is crucial for managing resources on AWS, such as uploading and downloading backup files from S3 buckets.
* MySQL Client: Equipped with the MySQL client, this image facilitates direct interactions with MySQL databases. It's essential for executing database operations such as creating dumps and restoring data from backups.
* Backup and Restore Script: A custom script backup_restore_script.sh is included and pre-configured to automate backup and restore processes. This script interfaces with both AWS S3 (for storage) and the MySQL database, encapsulating the complexity of backup and restore operations into simple, executable commands.
* Security and Flexibility: Environment variables are used for configuring AWS and MySQL access, enhancing security and making the image adaptable to different environments and configurations.
* Lightweight Base Image: Built on Python 3.9-slim, the image is lightweight, reducing overhead and resource usage in containerized environments.

# Usage Scenarios

* Regularly scheduled backups of MySQL databases in Kubernetes clusters.
* Restoring databases from backups stored in AWS S3.
* Kubernetes deployments that require frequent data backup and restore operations.

# Configuration

AWS credentials and S3 bucket names must be provided through environment variables or mounted files.
MySQL database connection details (host, user, password, database name) are also provided via environment variables, allowing secure and flexible configurations.

# Getting Started

To use this image, pull it from its repository and run it with the necessary environment variables set for AWS and MySQL configurations. The image can be deployed as part of a Kubernetes job or a standalone container, depending on the backup/restore strategy implemented.

