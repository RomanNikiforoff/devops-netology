resource "yandex_compute_instance" "docker-node" {
  name                      = "docker-node"
  zone                      = "ru-central1-a"
  hostname                  = "docker.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8emvfmfoaordspe1jr"
      type        = "network-nvme"
      size        = "50"
    }
  }

  network_interface {
    subnet_id = "e9bopjo60lbholcap1u2"
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
    serial-port-enable = 1
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname docker-node",
      "echo '${var.user}:${var.user_password}' | sudo chpasswd"
    ]
  }
     
  connection {
      type = "ssh"
      user = var.user
      private_key = file(var.private_key_path)
      host = self.network_interface[0].nat_ip_address
  }
}
