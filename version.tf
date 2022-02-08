terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"

    }
  }
} 

provider "aws" {
  region = "${var.region}"
  access_key = "AKIAQCZIQ4X6CLWGZAOJ"
  secret_key = "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"
}