resource "yandex_compute_instance" "vm" {
  name = "vm-instance-${random_id.vm_suffix.hex}"

  resources {
    cores  = var.cpu_cores
    memory = var.memory_gb
  }

  boot_disk {
    initialize_params {
      image_id = "fd8iv792kirahhlqjvj8" # Ubuntu 22.04 LTS
      size     = 10 # ГБ
    }
  }

  secondary_disk {
    disk_id = yandex_compute_disk.additional_disk.id
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_key}"
  }
}

resource "yandex_compute_disk" "additional_disk" {
  name = "additional-disk-${random_id.vm_suffix.hex}"
  size = var.disk_size_gb
  type = "network-ssd"
}

resource "random_id" "vm_suffix" {
  byte_length = 4
}
