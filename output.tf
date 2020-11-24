output "lambda_name" {
  value = aws_lambda_function.ec2_scheduler.qualified_arn
}
