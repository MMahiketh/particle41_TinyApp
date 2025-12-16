terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.10.0"
    }
  }
  backend "s3" {
    bucket       = "particle41-dev-state-files"
    key          = "terraform-particle41.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true #S3 native locking
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}