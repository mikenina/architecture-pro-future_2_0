module "vm_module" {
  source      = "./modules/vm"
  cpu_cores   = 2
  memory_gb   = 4
  disk_size_gb = 100
  subnet_id   = "e2ld6g3j9g6167644qad"
  ssh_key      = file("~/.ssh/id_rsa.pub")
}

output "virtual_machine_ip" {
  value = module.vm_module.vm_ip
}
