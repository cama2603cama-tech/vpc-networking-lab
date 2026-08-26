# --- 1. VPC mynetwork ---
resource "google_compute_network" "mynetwork" {
  name                    = "mynetwork"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "mynetwork_us" {
  name          = "mynetwork-us"
  ip_cidr_range = "10.128.0.0/20"
  region        = var.region_us
  network       = google_compute_network.mynetwork.id
}

resource "google_compute_subnetwork" "mynetwork_eu" {
  name          = "mynetwork-eu"
  ip_cidr_range = "10.132.0.0/20"
  region        = var.region_eu
  network       = google_compute_network.mynetwork.id
}

# --- 2. VPC management ---
resource "google_compute_network" "management" {
  name                    = "management"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "managementsubnet_us" {
  name          = "managementsubnet-us"
  ip_cidr_range = "10.130.0.0/20"
  region        = var.region_us
  network       = google_compute_network.management.id
}

# --- 3. VPC privatenet ---
resource "google_compute_network" "privatenet" {
  name                    = "privatenet"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "privatesubnet_us" {
  name          = "privatesubnet-us"
  ip_cidr_range = "172.16.0.0/24"
  region        = var.region_us
  network       = google_compute_network.privatenet.id
}

resource "google_compute_subnetwork" "privatesubnet_eu" {
  name          = "privatesubnet-eu"
  ip_cidr_range = "172.20.0.0/20"
  region        = var.region_eu
  network       = google_compute_network.privatenet.id
}

# --- Reglas de Firewall básicas (SSH e ICMP) ---
resource "google_compute_firewall" "allow_all_ssh_icmp" {
  for_each = toset(["mynetwork", "management", "privatenet"])
  name     = "${each.key}-allow-ssh-icmp"
  network  = each.key

  # Forzamos explícitamente a que espere a que todas las redes estén creadas
  depends_on = [
    google_compute_network.mynetwork,
    google_compute_network.management,
    google_compute_network.privatenet
  ]

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# 1. mynet-us-vm
resource "google_compute_instance" "mynet_us_vm" {
  name         = "mynet-us-vm"
  machine_type = "e2-micro"
  zone         = "${var.region_us}-a"
  tags         = ["allow-ssh", "allow-icmp"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.mynetwork_us.id
    network_ip = "10.128.0.2"
    access_config {}
  }
}

# 2. mynet-eu-vm
resource "google_compute_instance" "mynet_eu_vm" {
  name         = "mynet-eu-vm"
  machine_type = "e2-micro"
  zone         = "${var.region_eu}-b"
  tags         = ["allow-ssh", "allow-icmp"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.mynetwork_eu.id
    network_ip = "10.132.0.2"
    access_config {}
  }
}

# 3. management-us-vm
resource "google_compute_instance" "management_us_vm" {
  name         = "management-us-vm"
  machine_type = "e2-micro"
  zone         = "${var.region_us}-a"
  tags         = ["allow-ssh", "allow-icmp"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.managementsubnet_us.id
    network_ip = "10.130.0.2"
    access_config {}
  }
}

# 4. privatenet-us-vm
resource "google_compute_instance" "privatenet_us_vm" {
  name         = "privatenet-us-vm"
  machine_type = "e2-micro"
  zone         = "${var.region_us}-a"
  tags         = ["allow-ssh", "allow-icmp"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.privatesubnet_us.id
    network_ip = "172.16.0.2"
    access_config {}
  }
}