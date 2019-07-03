provider "aws" {
  region = "${var.region}"
}

module "production-state" {
  source = "./state"

  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    bucket  = "production-state-file"
    key     = "terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

module "production-infrastructure" {
  source = "./infrastructure"

  environment = "${var.environment}"
}

output "web-alb-dns-name" {
  value = "${module.production-infrastructure.web-alb-dns-name}"
}

output "web-instance-ips" {
  value = "${module.production-infrastructure.web-instance-ips}"
}
