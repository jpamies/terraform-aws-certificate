# AWS Certificate Module Example

This directory provides a working example of how to use the AWS Certificate module to create and validate SSL certificates using Route53.

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in your values:

```
domain_zone_id = "Z1234567890ABC"
domain = "example.com"
alternate_domains = ["*.example.com", "app.example.com"]
tags = {
  Environment = "example"
  Project = "certificate-demo"
}
```

2. Initialize Terraform:

```bash
terraform init
```

3. Plan the deployment:

```bash
terraform plan
```

4. Apply the configuration:

```bash
terraform apply
```

## What This Example Creates

- An AWS ACM certificate for your domain and any alternate domains
- Route53 DNS records to validate the certificate
- An Application Load Balancer that uses the certificate

## Notes

- All domains must be managed by the same Route53 zone
- The example uses an Application Load Balancer, but you can use the certificate with any AWS service that supports ACM certificates
- Certificate validation typically takes 5-30 minutes to complete
