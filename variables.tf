variable "tag_key" {
  default = "Env"
  type    = string
}

variable "tag_value" {
  default = "dev"
  type    = string
}

variable "schedule_action" {
  default = "start"
  type    = string
}

variable "ec2_schedule" {
  default = "true"
  type    = string
}

variable "schedule_time" {
  default = "cron(0 8 ? * MON-FRI *)"
  type    = string
}
