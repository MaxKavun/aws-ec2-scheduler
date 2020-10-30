terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.12"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-north-1"
}

data "archive_file" "lambda_func" {
  type        = "zip"
  source_dir  = "${path.module}/package"
  output_path = "${path.module}/package.zip"
}

resource "aws_iam_role" "lambda_ec2_manage" {
  name               = "ec2-manager-for-lambda"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
}
EOF
}

resource "aws_iam_policy" "ec2_start_stop" {
  name        = "ec2-start-stop"
  description = "allow start stop ec2 by lambda"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
     {
        "Action": [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
     }
   ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda-attach" {
  role       = aws_iam_role.lambda_ec2_manage.name
  policy_arn = aws_iam_policy.ec2_start_stop.arn
}

resource "aws_lambda_function" "ec2_scheduler" {
  filename      = "${path.module}/package.zip"
  function_name = "ec2_scheduler"
  role          = aws_iam_role.lambda_ec2_manage.arn
  handler       = "scheduler.app.lambda_handler"

  runtime = "python3.8"
  environment {
    variables = {
      TAG_KEY         = "Env"
      TAG_VALUE       = "dev"
      SCHEDULE_ACTION = "start"
      EC2_SCHEDULE    = "true"
    }
  }
}

resource "aws_cloudwatch_event_rule" "ec2-start" {
  name                = "ec2-rule-start"
  description         = "Rule to start ec2 instances"
  schedule_expression = "cron(0 8 ? * MON-FRI *)"
}


