# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "dns_zone_id" {
  description = "Route53 Zone id handling the domains on the certificate"
  type        = string
}

variable "domain_name" {
  description = "Main domain name for the SSL certificate"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "dns_ttl" {
  description = "DNS records TTL"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags associated to the certificate"
  type        = map(string)
  default     = {}
}

variable "subject_alternative_names" {
  description = "Alternate domain names for the SSL certificate"
  type        = list(string)
  default     = []
}

variable "key_algorithm" {
  description = "Algorithm for the certificate's private key. RSA_2048, EC_prime256v1, EC_secp384r1, or RSA_1024"
  type        = string
  default     = "RSA_2048"
  
  validation {
    condition     = contains(["RSA_2048", "EC_prime256v1", "EC_secp384r1", "RSA_1024"], var.key_algorithm)
    error_message = "Valid values for key_algorithm are: RSA_2048, EC_prime256v1, EC_secp384r1, or RSA_1024."
  }
}

variable "validation_timeout" {
  description = "Timeout for ACM to validate the certificate"
  type        = string
  default     = "45m"
}
