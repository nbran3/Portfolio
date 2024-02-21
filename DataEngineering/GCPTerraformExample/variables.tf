variable "credentials" {
  description = "GCP credentials"
  default     = "./keys/my-creds.json"

}

variable "project" {
  description = "GCP Project ID"
  default     = "terraform-demo-414703"
}

variable "location" {
  description = "GCP Project Location"
  default     = "US"
}

variable "region" {
  description = "GCP Region Name"
  default     = "us-central1"
}

variable "bq_dataset_name" {
  description = "BigQuery dataset name"
  default     = "demo_dataset"

}

variable "gcs_bucket_name" {
  description = "GCP Storage Bucket Name"
  default     = "terraform-demo-414703-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

