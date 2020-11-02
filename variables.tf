variable "tag_key" {
  default = "Env"
  type = string
}

variable "tag_value" {
  default = "dev"
  type = string
}

variable "schedule_action" {
  default = "start"
  type = string
}

variable "ec2_schedule" {
  default = "true"
  type    = string
}
