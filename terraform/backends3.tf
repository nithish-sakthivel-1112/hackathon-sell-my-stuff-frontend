terraform {
  backend "s3" {
    bucket = "terraform-tfstate-nithish"
    key    = "s3/terraform.tfstate"
    region = "eu-central-1"
  }
}
