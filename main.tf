terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.35.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "bterraformstate"
    container_name       = "tfstate"
    key                  = "pipeline-github/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "brancalliao"
      managed-by = "terraform"
    }
  }
}


provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "brancalliao-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "bterraformstate"
    container_name       = "tfstate"
    key                  = "vnet/terraform-state"
  }
}