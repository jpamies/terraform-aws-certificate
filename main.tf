######
# AWS certificate
######
resource "aws_acm_certificate" "this" {
  domain_name               = "${var.domain_name}"
  validation_method         = "DNS"
  subject_alternative_names = "${var.subject_alternative_names}"
  tags                      = "${var.tags}"
}

resource "aws_acm_certificate_validation" "this" {
  depends_on              = ["aws_acm_certificate.this"]
  certificate_arn         = "${aws_acm_certificate.this.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.*.fqdn }"]
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
  count           = "${length(var.subject_alternative_names)+1}"
  name            = "${lookup(aws_acm_certificate.this.domain_validation_options[count.index],"resource_record_name")}"
  type            = "CNAME"
  allow_overwrite = true
  zone_id         = "${var.dns_zone_id}"
  records         = ["${lookup(aws_acm_certificate.this.domain_validation_options[count.index],"resource_record_value")}"]
  ttl             = "${var.dns_ttl}"
}
