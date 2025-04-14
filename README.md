# AWS Certificate Module [![Terraform](https://github.com/jpamies/terraform-aws-certificate/actions/workflows/terraform.yml/badge.svg)](https://github.com/jpamies/terraform-aws-certificate/actions/workflows/terraform.yml)

This module creates AWS ACM certificates and validates them using Route53 DNS records, allowing you to provision SSL certificates completely through Terraform without manual intervention.

## Features

- Automatic creation and validation of AWS ACM certificates
- DNS validation using Route53
- Support for wildcard certificates and multiple subdomains
- Configurable key algorithm and validation timeout
- Lifecycle management for certificate renewal
- Fully automated dependency updates and releases

## Requirements

- Terraform version >= 1.0.0
- Terraform AWS Provider version >= 4.0, < 6.0

## Usage

```hcl
module "certificate" {
  source                    = "jpamies/certificate/aws"
  version                   = "~>2.0"
  domain_name               = "example.com"
  subject_alternative_names = ["*.example.com", "app.example.com"]
  dns_zone_id               = "Z1234567890ABC"
  tags = {
    Environment = "production"
    Project     = "website"
  }
}
```

## Domain Support

This module can be used to create:

- Single domain certificates: `example.com`
- Wildcard certificates: `*.example.com`
- Multi-domain certificates: `example.com`, `*.example.com`, `app.example.com`

**Important**: All domains must be managed by the same Route53 zone.

Examples:
- ✅ `example.com`, `*.example.com`
- ✅ `example.com`, `app.example.com`
- ❌ `example.com`, `different.com` (different domains)

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| domain_name | Main domain name for the SSL certificate | `string` | n/a | yes |
| dns_zone_id | Route53 Zone ID handling the domains on the certificate | `string` | n/a | yes |
| subject_alternative_names | Alternate domain names for the SSL certificate | `list(string)` | `[]` | no |
| dns_ttl | DNS records TTL | `number` | `60` | no |
| tags | Tags associated with the certificate | `map(string)` | `{}` | no |
| key_algorithm | Algorithm for the certificate's private key | `string` | `"RSA_2048"` | no |
| validation_timeout | Timeout for ACM to validate the certificate | `string` | `"45m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | ARN associated with the generated certificate |
| domain_validation_options | Domain validation options for the certificate |
| certificate_domain_name | The domain name for which the certificate is issued |
| certificate_status | Status of the certificate |

## Examples

Check the [examples](https://github.com/jpamies/terraform-aws-certificate/tree/master/examples) directory for detailed working examples.

## Version Compatibility

- For Terraform >= 1.0: Use version ~> 2.0
- For Terraform >= 0.12.20, < 1.0: Use version ~> 1.0
- For Terraform < 0.12: Use version ~> 0.0

## Module Structure

* [root](https://github.com/jpamies/terraform-aws-certificate/tree/master): Contains the main Terraform module files
* [examples](https://github.com/jpamies/terraform-aws-certificate/tree/master/examples): Contains examples of how to use the module
* [tests](https://github.com/jpamies/terraform-aws-certificate/tree/master/tests): Contains automated tests for the module

## Versioning

This module follows [Semantic Versioning](http://semver.org/). See the [Releases Page](../../releases) for the changelog.

## Automated Updates

This module uses GitHub Actions to automate dependency updates and releases:

- **Dependabot Integration**: Automatically creates PRs for outdated dependencies
- **Automatic PR Labeling**: Labels PRs based on content and branch names
- **Automatic Merging**: Merges Dependabot PRs automatically after tests pass
- **Smart Versioning**: Determines version bumps based on PR labels and commit messages
- **Automated Releases**: Creates tags and releases with categorized changelogs
- **Release Notifications**: Sends notifications when new versions are released

The automation system ensures that the module stays up-to-date with minimal manual intervention, handling everything from dependency updates to versioning and release notes generation.

## Contributing

Contributions are welcome! Please see the [Contribution Guidelines](https://github.com/jpamies/terraform-aws-certificate/tree/master/CONTRIBUTING.md) for instructions.

## License

This code is released under the Apache 2.0 License. Please see [LICENSE](https://github.com/jpamies/terraform-aws-certificate/tree/master/LICENSE) for details.
