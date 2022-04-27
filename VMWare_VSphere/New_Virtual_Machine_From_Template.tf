resource "vsphere_virtual_machine" "vm" {
  network_interface {
    network_id = var.network_id
  }

  customize {
    network_interface {
    }
  }

}
