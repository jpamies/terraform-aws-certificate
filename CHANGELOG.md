# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-04-09

### Added
- Support for configurable key algorithm
- Support for validation timeout configuration
- Added lifecycle management for certificate renewal
- Added additional outputs (domain_validation_options, certificate_domain_name, certificate_status)
- Added proper type constraints to all variables
- Added validation for key_algorithm variable

### Changed
- Updated minimum Terraform version to 1.0.0
- Updated AWS provider compatibility to >= 4.0, < 6.0
- Improved CircleCI configuration to use Terraform orb
- Completely restructured README with clearer sections and better documentation
- Updated examples to use modern AWS resources (ALB instead of classic ELB)

### Fixed
- Fixed outdated documentation links
- Improved code formatting and consistency

## [1.0.0] - Previous Release

### Added
- Initial stable release with support for Terraform 0.12+
- AWS ACM certificate creation and validation
- Route53 DNS validation
- Support for wildcard certificates and multiple subdomains

## [0.0.5] - Initial Release

### Added
- Initial release with support for Terraform < 0.12
- Basic certificate creation and validation functionality
