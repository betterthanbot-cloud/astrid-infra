# stage/terragrunt.hcl
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "aws-astrid-infra"

    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "aws-astrid-infra-terraform-statefile-lock"
  }
}

locals {
  dirs   = split("/", path_relative_to_include())
  env    = local.dirs[0]
  common = yamldecode(file("common.yaml"))
}

inputs = merge(
  {
    base_tags = merge(
      local.common.base_tags,
      {
        Environment = local.env
    })
})
