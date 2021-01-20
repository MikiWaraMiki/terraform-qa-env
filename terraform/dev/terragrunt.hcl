locals {
  // backend-config.ymlを読み込む
  backend_config = yamldecode(file("${find_in_parent_folders("backend-config.yml")}"))
}
remote_state {
  backend = "s3"
  config = {
    bucket  = local.backend_config.bucket
    key     = "${local.backend_config.key_base}/${path_relative_to_include()}.tfstate"
    region  = local.backend_config.region
    encrypt = local.backend_config.encrypt
    profile = local.backend_config.profile
  }
}
terraform {
  extra_arguments "common_var" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]

    required_var_files = [
      "${get_parent_terragrunt_dir()}/config.tfvars"
    ]
  }
}
