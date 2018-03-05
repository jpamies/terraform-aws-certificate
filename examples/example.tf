provider "aws" {
  region = "us-east-1"
}

variable "domain_zone_id" {}
variable "domain" {}

variable "alternate_domains" {
  type = "list"
}

variable "tags" {
  default = {}
}

module "cert" {
  source                    = ".."
  domain_name               = "${var.domain}"
  subject_alternative_names = ["${var.alternate_domains}"]
  dns_zone_id               = "${var.domain_zone_id}"
  tags                      = "${var.tags}"
}

######
# AWS ELB using the certificate dinamically generated
######
resource "aws_elb" "bar" {
  name               = "aws-cert-elb"
  availability_zones = ["us-east-1a", "us-east-1b"]

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${module.cert.arn}"
  }

  instances                   = []
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "cert-elb"
  }
}
