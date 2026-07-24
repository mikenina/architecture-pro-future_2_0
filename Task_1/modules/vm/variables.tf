variable "cpu_cores" {
  description = "CPU cores number alocated to a VM"
  type        = number
  validation {
    condition     = var.cpu_cores >= 1
    error_message = "CPU cores number must be a positive integer"
  }
}

variable "memory_gb" {
  description = "RAM size allocated to a VM"
  type        = number
  validation {
    condition     = var.memory_gb >= 1
    error_message = "Minimum RAM size is 1GB"
  }
}

variable "disk_size_gb" {
  description = "Storage size allocated to a VM"
  type        = number
  default     = 10
  validation {
    condition     = var.disk_size_gb >= 10
    error_message = "Minimum stoage size is 10 GB."
  }
}

variable "subnet_id" {
  description = "Subnet ID to deploy VM at"
  type        = string
}

variable "ssh_key" {
  description = "SSH Public key for a VM"
  type        = string
  sensitive   = true
}
