output "arn" {
  description = "ARN associated to the generated certificate"
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "domain_validation_options" {
  description = "Domain validation options for the certificate"
  value       = aws_acm_certificate.this.domain_validation_options
}

output "certificate_domain_name" {
  description = "The domain name for which the certificate is issued"
  value       = aws_acm_certificate.this.domain_name
}

output "certificate_status" {
  description = "Status of the certificate"
  value       = aws_acm_certificate.this.status
}
