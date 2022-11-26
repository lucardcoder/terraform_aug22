resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-standard-2"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

	
	metadata = {
		ssh-keys = "admin-user:${file("~/.ssh/id_rsa.pub")}"
	}


  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}