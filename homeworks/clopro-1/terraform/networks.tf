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

# Privat subnet
resource "yandex_vpc_subnet" "private" {
  name           = var.vpc_name_privat
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  route_table_id = yandex_vpc_route_table.netology-routing.id
  v4_cidr_blocks = var.privat_cidr
}

# Routing table
resource "yandex_vpc_route_table" "netology-routing" {
  name       = "netology-routing"
  network_id = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}
