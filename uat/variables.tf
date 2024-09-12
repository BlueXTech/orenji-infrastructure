variable "environment" {
  description = "Environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "ami" {
  description = "AMI id"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_profile" {
  description = "EC2 instance profile"
  type        = string
}

variable "ec2_key_name" {
  description = "Key name"
  type        = string
}

variable "asg_min_size" {
  description = "Autoscaling group minimum size"
  type        = number
}

variable "asg_max_size" {
  description = "Autoscaling group maximum size"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Autoscaling group desired capacity"
  type        = number
}

variable "asg_azs" {
  description = "Availability zones for ASG"
  type        = list(string)
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
}

variable "subnets" {
  description = "Subnets"
  type        = list(string)
}

variable "alb_enable_deletion_protection" {
  description = "Enable deletion protection on ALB"
  type        = bool
}

variable "alb_listener_ssl_policy" {
  description = "ALB listener ssl policy"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate arn"
  type        = string
}

variable "hosted_zone_id" {
  description = "Hosted zone id for orang3-app.com"
  type        = string
}

variable "alb_alias_url" {
  description = "Url for ALB (A record)"
  type        = string
}