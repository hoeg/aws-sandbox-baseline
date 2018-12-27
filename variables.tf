variable "region" {
  description = "Region to deploy resources in."
}

variable "max-spend" {
  description = "Maximum amount to spend on the accoung pr. month."
}

variable "cloudtrail-bucket-name" {
  description = "Name of the bucket holding the cloudtrail logs."
}

variable "username" {
  description = "Name of the admin user created"
}
