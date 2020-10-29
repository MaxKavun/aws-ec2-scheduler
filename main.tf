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

resource "aws_lambda_function" "ec2_scheduler" {
  filename      = "${path.module}/package.zip"
  function_name = "ec2_scheduler"
  role          = "arn:aws:iam::673907469822:role/scheduler"
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
