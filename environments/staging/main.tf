provider "aws" {
  region = "${var.region}"
}

module "staging-state" {
  # source = "../../modules/state"
  # source = "/root/example/modules/state"
  # source = "~/example/modules/state"
  source = "~/example/environments/staging/modules/state"

environments/$TERRAFORM_ENVIRONMENT

  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    bucket  = "staging-state-file"
    key     = "terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

module "staging-infrastructure" {
  source = "~/example/environments/staging/modules/infrastructure"

  environment = "${var.environment}"
}

output "web-alb-dns-name" {
  value = "${module.staging-infrastructure.web-alb-dns-name}"
}

output "web-instance-ips" {
  value = "${module.staging-infrastructure.web-instance-ips}"
}
