output "vm_id" {
  value     = yandex_compute_instance.vm.id
  description = "ID созданной виртуальной машины"
}

output "vm_ip" {
  value     = yandex_compute_instance.vm.network_interface.0.nat_ip_address
  description = "Публичный IP‑адрес виртуальной машины"
}

output "disk_id" {
  value     = yandex_compute_disk.additional_disk.id
  description = "ID подключённого диска"
}
