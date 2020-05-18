terraform {
    /**
     * Using local backend, saving `.tfstate` file on Git.
     * Using 'S3' backend for remote state is highly recommended.
     * @see https://www.terraform.io/docs/backends/types/s3.html    
     */
    backend "local" {
        path = "./states/terraform.tfstate"
    }

    // Terraform 0.12+ version is needed.
    required_version = ">= 0.12"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  
  region = "${var.region}"
  version = "~> 2.29"
}

