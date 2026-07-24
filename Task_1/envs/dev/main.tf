terraform {
  backend "local" {}
}

variable "cpu_cores" {
  default = ""
}
variable "memory_gb" {
  default = ""
}
variable "disk_size_gb" {
  default = ""
}
variable "subnet_id" {
  default = ""
}
variable "ssh_key" {
  default = ""
}

module "vm" {
  source      = "../../modules/vm"
  cpu_cores   = var.cpu_cores
  memory_gb   = var.memory_gb
  disk_size_gb = var.disk_size_gb
  subnet_id   = var.subnet_id
  ssh_key     = var.ssh_key
}

output "dev_vm_ip" {
  value = module.vm.vm_ip
}
