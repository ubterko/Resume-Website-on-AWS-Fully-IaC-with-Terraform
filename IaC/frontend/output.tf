output "bucket_id" {
    description = "ID of the resume bucket."
    value       = aws_s3_bucket.resume_bucket.id
    # after you run `terraform apply`
    # From CLI: 
    #   terraform output bucket-id
}