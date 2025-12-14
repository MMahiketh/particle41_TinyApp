terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
  backend "s3" {
    bucket         = "particle41-dev-state-files"
    key            = "terraform-particle41-dev-vpc"
    region         = "us-east-1"
    dynamodb_table = "particle41-dev-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}