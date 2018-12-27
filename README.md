# aws-sandbox-baseline
Baseline AWS setup for sandbox account. 

# What it does

By applying this terraform module to your AWS account you will have a baseline setup that will give you insights in to the usage of you account and adhere to AWS best practices.

This module will set up:

- Cloudtrail
- Bucket for storing cloudtrail logs
- Lifetime managemen of the logs
- IAM admin user
- Password policy for users
- Budget cost rule

more will be added...

