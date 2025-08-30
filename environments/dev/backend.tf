terraform {
  backend "s3" {
    bucket = "udemy-terraform-nonoguchi"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}