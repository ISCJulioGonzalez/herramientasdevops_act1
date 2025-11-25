#!/bin/bash

#1 Run the packer build
echo "Starting Packer Build..."
packer build ami_template.json

#2 Capture the AMI ID from the packer manifest
AMI_ID=$(jq -r '.builds[-1].artifact_id' packer-manifest.json | cut -d: -f2)
IMAGE_NAME=$(jq -r '.builds[] | select(.builder_type=="googlecompute") | .artifact_id' packer-manifest.json)

if [ -z "$AMI_ID" ]; then
  echo "Failed to retrieve AMI ID from Packer manifest."
  exit 1
fi

echo "Packer Build completed. AMI ID: $AMI_ID"

#3 Run the Terraform deployment
echo "Starting Terraform Deployment for AWS..."
cd terraform/aws

terraform init

terraform apply -var="ami_id=$AMI_ID" -auto-approve

#4 Run the Terraform deployment
echo "Starting Terraform Deployment for GCP..."
cd .. terraform
cd terraform/azure

terraform init

terraform apply -var="image_name=$IMAGE_NAME" -auto-approve