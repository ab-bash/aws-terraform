terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "states/terraform.tfstate"
    region 	   = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
