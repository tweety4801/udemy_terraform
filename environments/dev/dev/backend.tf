terraform {
  backend "s3" {
    bucket = "udemy-terraform-s3-oshima"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
