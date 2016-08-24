#App Cartridge: Trend micro agent

Welcome to the REAN Trend Micro agent app cartridge! This cartridge contains the `cic_trendmicro_agent` cookbook for installing Trend micro's deep security agent. Please see the [cookbook readme](chef/cookbooks/cic_trendmicro_agent/README.md) for specific information on how the cookbook is meant to be used.

### What is an App Cartridge?

App cartridges are meant to be used in our Cicada/RIFF pipeline to set up the application tier of a customer's infrastructure. To that end, a cartridge contains the Terraform code necessary to set up EC2 instances, a Chef cookbook for software configuration, and a Packer template for generating an AMI.

### Software Prerequisites
* [ChefDK](https://downloads.chef.io/chef-dk/)
  - **note:** This project was developed on a machine running ChefDK 0.16.28
* [Terraform](https://www.terraform.io/downloads.html)
* [Packer](https://www.packer.io/downloads.html)
* [packer-post-processor-json-updater plugin](https://github.com/cliffano/packer-post-processor-json-updater)
  - See [here](https://www.packer.io/docs/templates/post-processors.html) for more information on Packer post-processors.

