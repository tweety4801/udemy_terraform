terraform {
  backend "s3" {
    bucket = "udemy-terraform-s3-oshima"
    key    = "prod/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
