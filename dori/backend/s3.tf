#create backend s3 bucket
resource "aws_s3_bucket" "dori-backend" {
  bucket        = "dori-backend234"
  force_destroy = true
  tags = {
    Name = "dori-backend"
  }
}


# Creating the backend S3 Bucket acl
resource "aws_s3_bucket_acl" "dori_backend-acl-s3" {
  bucket = aws_s3_bucket.dori-backend.id
  acl    = "private"
}

################
# DYNAMODB TABLE
################

resource "aws_dynamodb_table" "tflock" {
  name     = "dori-dynamo-table234"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"

  }

  write_capacity = 1
  read_capacity  = 1


  tags = {

    Name        = "TF State Lock"
    Environment = "Terraform"

  }

}