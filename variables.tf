variable "region" {
  description = "The AWS region to use"
}

variable "shared_credentials_file" {
  description = "The location of the AWS shared credentials file (e.g. ~dominic/.aws/credentials)"
}

variable "profile" {
  description = "The AWS profile to use"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create that will eventually host the Helm chart repository"
}

variable "repository_name" {
  description = "The name of the Helm chart repository"
}

variable "log_bucket_id" {
  description = "The ID of the S3 bucket to use for storing S3 access logs"
}

variable "is_versioning_enabled" {
  description = "Enable versioning?"
  default     = true
}

variable "is_forcing_destroy" {
  description = "Force the bucket to be emptied before deletion when running 'terraform destroy'?"

  # Warning: USE AT YOUR OWN RISK!
  # Set to 'true' if you want the bucket to be emptied before deletion when running 'terraform destroy'
  default = false
}
