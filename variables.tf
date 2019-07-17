# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ---------------------------------------------------------------------------------------------------------------------
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "dns_zone_id" {
  description = "Route53 Zone id handleling the domains on the certificate"
}

variable "domain_name" {
  description = "Main domain name for the SSL certificate"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "dns_ttl" {
  description = "DNS records TTL"
  default     = 60
}

variable "tags" {
  description = "Tags associated to the certificate"
  default     = {}
}

variable "subject_alternative_names" {
  description = "Alternate domain names  for the SSL certificate"
  type        = list(string)
  default     = []
}
