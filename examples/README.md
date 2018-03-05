HTTPS ELB example
====================

Configuration in this directory creates a certificate using the `terraform-aws-certificate` module and use it for a ELB with HTTPS listeners.

You need to specify the Route53 Zone related with the certificate domain.

Usage
=====

Check the [terraform.tfvars](terraform.tfvars) and fill with the domains you want to use and also the Route53 zone_id.

Once you've set up the variables you just need need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

We're using us-east-1 as a default region to run the test, if you want to change it just check [example.tf](example.tf).

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.
