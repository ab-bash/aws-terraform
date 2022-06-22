terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "states/terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}
