variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "kubernetes_version" {
  description = "kubernetes version"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "vpc subnet ids"
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "endpoint_public_access"
  type        = bool
  default     = false
}

variable "desired_size" {
  description = "EKS desired size"
  type        = number
}

variable "max_size" {
  description = "EKS max size"
  type        = number
}

variable "min_size" {
  description = "EKS min size"
  type        = number
}
