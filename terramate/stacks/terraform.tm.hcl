generate_hcl "_terramate_generated_terraform.tf" {
  content {
    terraform {
      required_version = global.terraform_version
    }
  }
}
