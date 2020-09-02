######
# AWS certificate
######
resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = var.subject_alternative_names
  tags                      = var.tags
}

resource "aws_acm_certificate_validation" "this" {
  depends_on              = [aws_acm_certificate.this]
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

######
# Route53
# Records to validate the certificate
######

##
# Due being unable to perform a function call length on a computed value
# count      = "${length(aws_acm_certificate.this.domain_validation_options)}"
# We're using the list of the SAN + the main domain as a workaround
# count      = "${length(var.subject_alternative_names)+1}"
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type

    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.dns_ttl
  type            = each.value.type
  zone_id         = var.dns_zone_id

}
