provider "aws" {
  region = "${var.region}"
}

module "staging-state" {
  source = "./state"

  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    # bucket  = "staging-state-file"
    bucket  = "terrastate-stage"
    key     = "terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

module "staging-infrastructure" {
  source = "./infrastructure"

  environment = "${var.environment}"
}

output "web-alb-dns-name" {
  value = "${module.staging-infrastructure.web-alb-dns-name}"
}

output "web-instance-ips" {
  value = "${module.staging-infrastructure.web-instance-ips}"
}
