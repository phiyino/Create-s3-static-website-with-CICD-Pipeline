# configure aws provider
provider "aws" {
    region = var.region
}

#configure s3 bucket
module "S3" {
    source = "../modules/S3"
    bucket_name = var.bucket_name
    my_origin_access_identity = module.cloudfront.my_origin_access_identity
}

#configure cloudfront
module "cloudfront" {
    source = "../modules/cloudfront"
    S3_bucket  = module.S3.S3_bucket
  
}

#configure codepipeline
module "codepipeline" {
    source = "../modules/codepipeline"
    S3_bucket = module.S3.S3_bucket
  
}