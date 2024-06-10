terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.53.0"
      configuration_aliases = [aws.ohio, aws.northvirginia,aws.Ireland]
    }
  }
}


provider "aws" {
  region = "us-east-1"
  alias = "ohio"
}

provider "aws" {
  region = "us-east-2"
  alias = "northvirginia"
}

provider "aws" {
  region = "eu-west-1"
  alias = "Ireland"
}