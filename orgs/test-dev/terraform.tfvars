terragrunt {
  iam_role = "arn:aws:iam::576536126380:role/OrganizationAccountAccessRole"

  remote_state {
    backend = "s3"

    config {
      # bucket = "terraform-state-test-dev-${get_aws_account_id()}" # Bug here in: terragrunt version v0.17.3.. returns the main account not the sub account
      bucket         = "terraform-state-test-dev-576536126380"
      region         = "us-west-2"
      dynamodb_table = "terraform-locks"
      key            = "${path_relative_to_include()}/terraform.tfstate"
      encrypt        = true
    }
  }

  terraform {
    extra_arguments "comands_that_need_vars" {
      commands = ["init", "${get_terraform_commands_that_need_vars()}"]

      optional_var_files = [
        "${get_tfvars_dir()}/${find_in_parent_folders("org.tfvars")}",
        "${get_tfvars_dir()}/${find_in_parent_folders("env.tfvars")}",
        "${get_tfvars_dir()}/${find_in_parent_folders("region.tfvars")}",
      ]
    }
  }
}
