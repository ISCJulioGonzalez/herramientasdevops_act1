provider "google" {
  project = var.project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

# Clave SSH
resource "tls_private_key" "myapp_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  filename        = "${path.module}/${var.key_name}"
  content         = tls_private_key.myapp_key.private_key_pem
  file_permission = "0400"
}

# Red por defecto
data "google_compute_network" "default" {
  name = "default"
}

# Firewall (equivalente a Security Group)
resource "google_compute_firewall" "myapp_fw" {
  name    = "myapp-fw"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["myapp-server"]
}

# Instancia
resource "google_compute_instance" "myNginxNodeJS" {
  name         = "dmd-nginx-server"
  machine_type = var.instance_type
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }

  network_interface {
    network = data.google_compute_network.default.name
    access_config {} # Para IP pública
  }

  metadata = {
    ssh-keys = "terraform:${tls_private_key.myapp_key.public_key_openssh}"
  }

  tags = ["myapp-server"]
}
