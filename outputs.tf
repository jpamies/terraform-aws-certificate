output "arn" {
  description = "ARN associated to the generated certificate"
  value       = "${aws_acm_certificate.this.arn}"
}
