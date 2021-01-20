terraform {
  required_version = ">=0.13.0"
  backend "s3" {}
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

module "ecr" {
  source = "../../elements/ecr/"

  name                 = "ecr-${var.pj_prefix}"
  pj_prefix            = var.pj_prefix
  scan_on_push         = var.scan_on_push
  image_tag_mutability = var.image_tag_mutability
}
