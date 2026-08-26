output "vm_private_ips" {
  description = "Direcciones IP privadas de las VMs de laboratorio"
  value = {
    mynet_us      = google_compute_instance.mynet_us_vm.network_interface[0].network_ip
    mynet_eu      = google_compute_instance.mynet_eu_vm.network_interface[0].network_ip
    management_us = google_compute_instance.management_us_vm.network_interface[0].network_ip
    privatenet_us = google_compute_instance.privatenet_us_vm.network_interface[0].network_ip
  }
}