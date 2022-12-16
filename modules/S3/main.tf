#create a bucket
resource "aws_s3_bucket" "ecommercewebsitebucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.ecommercewebsitebucket.id
  acl    = "private"
}

#create bucket version
resource "aws_s3_bucket_versioning" "my_versioning" {
  bucket = aws_s3_bucket.ecommercewebsitebucket.id
  versioning_configuration {
    status = "Enabled"
  }
} 

resource "aws_s3_bucket_website_configuration" "ecommercewebsitebucket" {
  bucket = aws_s3_bucket.ecommercewebsitebucket.bucket

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.ecommercewebsitebucket.id
  policy = data.aws_iam_policy_document.allow_access.json
}


data "aws_iam_policy_document" "allow_access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.ecommercewebsitebucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.my_origin_access_identity.iam_arn]
    }
  }
}
