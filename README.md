# AWS Certificate Module

This repo contains a Module to create AWS certificates and validate them  using route53 with terraform.

This module allows you to create SSL certificates without interaction, 100% with terraform.

This module can be used to create wildcard certificates, certificates with multiples subdomains but won't work with certificates with different domains. Ex:

- OK -> `jpamies.com`, `*.jpamies.com`
- OK -> `jpamies.com`, `staging.jpamies.com`
- FAIL -> `jpamies.com`, `.jordi.com`

All the requested domains should be managed by the same Route53 zone.

## How to use this Module

```hcl
module "certificate" {
  source                    = "jpamies/certificate/aws"
  domain_name               = "${var.domain}"
  subject_alternative_names = ["${var.alternate_domains}"]
  dns_zone_id               = "${var.domain_zone_id}"
  tags                      = "${var.tags}"
}
```

Check [examples](https://github.com/jpamies/terraform-aws-certificate/tree/master/examples) to view a detailed working example.


## How is structured this module

This Module has the following folder structure:

* [root](https://github.com/jpamies/terraform-aws-certificate/tree/master): This folder contains the terraform module.
 *  [main.tf](https://github.com/jpamies/terraform-aws-certificate/tree/master/main.tf): This file creates all the resources needed for the module.
 * [outputs.tf](https://github.com/jpamies/terraform-aws-certificate/tree/master/main.tf): This file contains the result of running the module.
 *  [variables.tf](https://github.com/jpamies/terraform-aws-certificate/tree/master/main.tf): This folder contains all the variables needed to run the terraform, optionals and mandatory.
* [examples](https://github.com/jpamies/terraform-aws-certificate/tree/master/examples): This folder contains examples of how to use the modules.
* [test](https://github.com/jpamies/terraform-aws-certificate/tree/master/test): Automated tests for the modules and examples.

## How is this Module versioned?

This Module follows the principles of [Semantic Versioning](http://semver.org/). You can find each new release,
along with the changelog, in the [Releases Page](../../releases).

During initial development, the major version will be 0 (e.g., `0.x.y`), which indicates the code does not yet have a
stable API. Once we hit `1.0.0`, we will make every effort to maintain a backwards compatible API and use the MAJOR,
MINOR, and PATCH versions on each release to indicate any incompatibilities.

## How do I contribute to this Module?

Everything related with terraform module structure, we try to follow @gruntwork-io style. Check https://www.gruntwork.io/ or @brikis98 's book for advanced terraform. Check out the [Contribution Guidelines](https://github.com/jpamies/terraform-aws-certificate/tree/master/CONTRIBUTING.md) for instructions.

## License

This code is released under the Apache 2.0 License. Please check [LICENSE](https://github.com/jpamies/terraform-aws-certificate/tree/master/LICENSE).
