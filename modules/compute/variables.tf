variable "environment" {}
variable "vpc_id" {}
variable "ami" {}
variable "instance_type" {}
variable "instance_profile" {}
variable "ec2_key_name" {}
variable "asg_min_size" {}
variable "asg_max_size" {}
variable "asg_desired_capacity" {}
variable "asg_azs" {}
variable "health_check_path" {}

# --- load-balancing ---
variable "subnets" {}
variable "alb_enable_deletion_protection" {}
variable "alb_listener_ssl_policy" {}
variable "acm_certificate_arn" {}

# --- route53 ---
variable "hosted_zone_id" {}
variable "alb_alias_url" {}


# variable "Environment" {
#   type        = string
#   description = "Application Environment (dev/stage/prod)"
# }

# variable "ami" {
#   type        = string
#   description = "EC2 Amazon Machine Image"
# }

# variable "instance_name" {
#   type        = string
#   description = "EC2 Instance Name"
# }

# variable "instance_type" {
#   type        = string
#   description = "EC2 Instance Type"
# }

# variable "subnet_id" {
#   type        = string
#   description = "Subnet ID"
# }

# variable "associate_public_ip_address" {
#   type        = bool
#   description = true
# }

# variable "key_name" {
#   type        = string
#   description = "Key Name"
# }

# variable "launch_template_name" {
#   type        = string
#   description = "Launch Template Name"
# }