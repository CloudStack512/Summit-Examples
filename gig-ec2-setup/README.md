# EC2 Setup Example

This project demonstrates provisioning an EC2 instance running Amazon Linux 2, installing Nginx, and serving a simple webpage.

## Files Included

- `ec2-user-data.sh` — User data script for automatic instance setup.

## Setup Instructions

1. Launch an EC2 instance (Amazon Linux 2 recommended).
2. Paste the contents of `ec2-user-data.sh` into the **User Data** field when launching.
3. Connect to the instance to verify Nginx is running:
   ```bash
   sudo systemctl status nginx
