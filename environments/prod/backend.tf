terraform {
  backend "s3" {
    bucket = "udemy-terraform-nonoguchi"
    key    = "prod/terraform.tfstate"
    region = "ap-northeast-1"
  }
}