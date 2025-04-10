provider "aws" {
  region = "us-east-1"
  # Use mock credentials for testing
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true

  # Mock endpoints for local testing
  endpoints {
    acm     = "http://localhost:4566"
    route53 = "http://localhost:4566"
  }
}

# Test the module with the test variables
module "test_certificate" {
  source                    = "./.."
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  dns_zone_id               = var.dns_zone_id
  tags                      = var.tags
  key_algorithm             = "RSA_2048"
  validation_timeout        = "5m" # Shorter timeout for testing
}

# Variables for testing
variable "domain_name" {
  type = string
}

variable "dns_zone_id" {
  type = string
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

# Output the certificate ARN for verification
output "certificate_arn" {
  value = module.test_certificate.arn
}

output "certificate_domain" {
  value = module.test_certificate.certificate_domain_name
}

output "certificate_status" {
  value = module.test_certificate.certificate_status
}
