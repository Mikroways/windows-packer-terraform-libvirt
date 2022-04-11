output "ip_address" {
  value = libvirt_domain.vm.network_interface.0.addresses.0
}

