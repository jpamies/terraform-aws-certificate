provider "aws" {
  region = "us-east-1"
}

variable "domain_zone_id" {
  type        = string
  description = "Route53 Zone ID for the domain"
}

variable "domain" {
  type        = string
  description = "Main domain name for the certificate"
}

variable "alternate_domains" {
  type        = list(string)
  description = "List of alternate domain names for the certificate"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

module "cert" {
  source                    = "./.."
  domain_name               = var.domain
  subject_alternative_names = var.alternate_domains
  dns_zone_id               = var.domain_zone_id
  tags                      = var.tags
  key_algorithm             = "RSA_2048"
  validation_timeout        = "45m"
}

######
# AWS Load Balancer using the certificate dynamically generated
######
resource "aws_lb" "example" {
  name               = "certificate-example-lb"
  internal           = false
  load_balancer_type = "application"
  
  # Replace with your actual subnet IDs
  subnets            = ["subnet-12345678", "subnet-87654321"]
  
  enable_deletion_protection = false

  tags = {
    Name = "certificate-example"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.example.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.cert.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Hello from the certificate example!"
      status_code  = "200"
    }
  }
}
