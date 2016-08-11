# Chef role for Trend Micro's Deep Security agent

## Prerequisites
* Install Chef
* Install Terraform
* Install Packer
* Install packer-post-processor-json-updater plugin from https://github.com/cliffano/packer-post-processor-json-updater

## Usage
From Root Directory Execute
* cd chef/cookbooks
* mkdir vendor
* cd cic-trendmicro
* berks vendor ../vendor
* cd ../../..
* packer build -var-file="<Packer JSON Vars File Path>" platform/aws/packer/ubuntu.json 
* cd platform/aws/terraform
* terraform apply -var-file="<Terraform JSON Vars File Path>" -var-file="../packer/target/ami.terraform.tfvars.json"
* **[To Destroy after verification]** terraform destroy -var-file="<Terraform JSON Vars File Path>" 

