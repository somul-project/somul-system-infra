variable "region" {
    default = "ap-northeast-2"
}

variable "access_key" {
    type = string
    description = "Access Key for AWS"
}

variable "secret_key" {
    type = string
    description = "Secret Key for AWS"
}

variable "key_pair" {
    /**
     * This key pair is not maintained by Terraform.
     * Deployers should pre-register their key on AWS.
     * @see AWS Console > EC2 > Key Pair
     */
    default = {
        "prod" = "<<key-pair-name>>"
        "staging" = "<<key-pair-name>>"
    }
}

variable "elb_certificate" {
    // If certificates are different, this area can be modified.
    default = {
        "prod" = "<<certificate acm>>"
        "staging" = "<<certificate acm>>"
    }
}

