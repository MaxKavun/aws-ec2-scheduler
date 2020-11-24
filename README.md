# Simple EC2 Instance Scheduler
A Terraform module for placing Lambda function with AWS EventBridge rules for scheduling start \ stop instances
### What is in progress?

- [x] Terraform wrapper for Python
- [x] Documentation
- [x] IAM Role creation
- [x] AWS EventBridge rule
- [x] AWS EventBridge target
- [x] Move all variables and add output to corresponding files

## Usage
```hcl
module "start_ec2_instances" {
  source          = "./aws-ec2-scheduler
  name            = "start"
  schedule_time   = "cron(0 8 ? * MON-FRI *)"
  tag_key         = "environment"
  tag_value       = "dev"
  schedule_action = "start"
  ec2_schedule    = "true"
}

module "stop_ec2_instances" {
  source          = "./aws-ec2-scheduler
  name            = "stop"
  schedule_time   = "cron(0 8 ? * MON-FRI *)"
  tag_key         = "environment"
  tag_value       = "dev"
  schedule_action = "stop"
  ec2_schedule    = "true"
}
```
