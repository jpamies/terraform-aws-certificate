# Testing the AWS Certificate Module

This directory contains files for testing the AWS Certificate module.

## Manual Testing

To test the module manually:

1. Navigate to this directory:
   ```bash
   cd /Users/jordipb/code/terraform-aws-certificate/tests
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Validate the module:
   ```bash
   terraform validate
   ```

4. Run a plan to see what would be created:
   ```bash
   terraform plan
   ```

## Testing with LocalStack

For more comprehensive testing without creating actual AWS resources, you can use LocalStack:

1. Start LocalStack:
   ```bash
   docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack
   ```

2. Run the tests:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```

3. Verify the outputs:
   ```bash
   terraform output
   ```

## CI/CD Testing

The module is automatically tested in CircleCI on each commit. The CI pipeline:

1. Checks formatting with `terraform fmt -check=true`
2. Initializes Terraform with `terraform init`
3. Validates the module with `terraform validate`
4. Runs a plan with `terraform plan`

## Pre-Release Testing

Before creating a release tag, it's recommended to:

1. Run all the tests above
2. Test the module in a real project by referencing it locally:
   ```hcl
   module "certificate" {
     source = "/path/to/terraform-aws-certificate"
     # variables...
   }
   ```
3. Create a pre-release tag for testing:
   ```bash
   git tag v2.0.0-beta.1
   git push origin v2.0.0-beta.1
   ```
