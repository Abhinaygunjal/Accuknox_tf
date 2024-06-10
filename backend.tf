terraform {
  backend "s3" {
    bucket         = "accuknox-example"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}
