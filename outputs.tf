output "arn" {
  description = "ARN associated to the generated certificate"
  value       = aws_acm_certificate_validation.this.certificate_arn
}
