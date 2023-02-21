terraform {

  backend "s3" {

    bucket         = "dori-backend237"
    key            = "dori/stage/compute/terraform.tfstate"
    region         = "eu-west-1"
    profile        = "default"
    dynamodb_table = "dori-dynamo-table237"

  }

}