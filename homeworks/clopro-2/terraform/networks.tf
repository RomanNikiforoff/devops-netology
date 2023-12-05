# VPC
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Public subnet
resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_name_public
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr
}
