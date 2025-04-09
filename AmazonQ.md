# AWS Certificate Module Testing Guide

This document provides guidance on testing the AWS Certificate module before publishing to the Terraform Registry.

## Prerequisites

- Terraform CLI installed (version >= 1.0.0)
- AWS CLI configured with appropriate credentials
- Git installed

## Testing Steps

### 1. Local Validation

```bash
# Format check
terraform fmt -recursive

# Initialize and validate
terraform init -backend=false
terraform validate
```

### 2. Test with Example Configuration

```bash
cd examples
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with real values
terraform init
terraform plan
```

### 3. Test with LocalStack (Optional)

For testing without creating real AWS resources:

```bash
# Start LocalStack
docker run --rm -it -p 4566:4566 localstack/localstack

# Run test configuration
cd tests
terraform init
terraform apply
```

### 4. Pre-Release Tag Testing

Create a pre-release tag to test the release process:

```bash
git tag v2.0.0-beta.1
git push origin v2.0.0-beta.1
```

This will trigger the GitHub Actions release workflow. Check if the tag appears correctly in the Terraform Registry and verify that the GitHub Actions workflow completes successfully.

### 5. Final Release

Once all tests pass, use the release script:

```bash
./release.sh 2.0.0
```

This will:
- Run final validation checks
- Create and push the tag v2.0.0
- The module will be published to the Terraform Registry

## Version Compatibility

- For Terraform >= 1.0: Use version ~> 2.0
- For Terraform >= 0.12.20, < 1.0: Use version ~> 1.0
- For Terraform < 0.12: Use version ~> 0.0

## Common Issues

- **Certificate validation timeout**: The default timeout is 45 minutes, which may be too short for some domains
- **Route53 permissions**: Ensure your AWS credentials have permissions to create Route53 records
- **Domain ownership**: All domains must be managed by the same Route53 zone
