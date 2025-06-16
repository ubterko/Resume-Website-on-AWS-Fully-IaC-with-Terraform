variable "resume_bucket_name" {
    description = "Name of the bucket used in holding static files."
    type = string
}

variable "logs_bucket_name" {
    description = "Name of bucket used in storing cloudfront logs."
    type = string
}
