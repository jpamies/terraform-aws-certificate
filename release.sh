#!/bin/bash
set -e

# Script to help with releasing new versions of the module

# Check if version is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  echo "Example: $0 2.0.0"
  exit 1
fi

VERSION=$1
TAG="v$VERSION"

# Confirm with user
echo "This will release version $VERSION with tag $TAG"
read -p "Are you sure? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Release cancelled"
  exit 1
fi

# Run tests
echo "Running format check..."
terraform fmt -check -recursive || { echo "Format check failed"; exit 1; }

echo "Running validation..."
terraform init -backend=false
terraform validate || { echo "Validation failed"; exit 1; }

# Create and push tag
echo "Creating tag $TAG..."
git tag $TAG
git push origin $TAG

echo "Version $VERSION released successfully!"
echo "The module will be available on the Terraform Registry once the tag is processed."
