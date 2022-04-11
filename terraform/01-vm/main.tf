
# see https://github.com/dmacvicar/terraform-provider-libvirt/blob/v0.6.10/website/docs/r/domain.html.markdown
resource "libvirt_domain" "vm" {
  name = var.prefix
  cpu {
    mode = "host-passthrough"
  }
  vcpu   = var.cpu
  memory = var.memory
  video {
    type = "qxl"
  }
  xml {
    xslt = file("libvirt-domain.xsl")
  }
  qemu_agent = true
  cloudinit  = libvirt_cloudinit_disk.cloudinit.id
  disk {
    volume_id = libvirt_volume.root.id
    scsi      = false
  }
  disk {
    volume_id = libvirt_volume.data.id
    scsi      = false
  }
  network_interface {
    bridge         = var.bridge
    wait_for_lease = true
    hostname       = var.prefix
  }
  provisioner "remote-exec" {
    inline = [
      <<-EOF
      rem this is a batch script.
      PowerShell "(Get-Content C:/cloudinit-config-example.ps1.log) -replace '^','C:/cloudinit-config-example.ps1.log: '"
      query session
      whoami /all
      ver
      PowerShell "Get-Disk | Select-Object Number,PartitionStyle,Size | Sort-Object Number"
      PowerShell "Get-Volume | Sort-Object DriveLetter,FriendlyName"
      EOF
    ]
    connection {
      type     = "winrm"
      user     = var.winrm_username
      password = var.winrm_password
      # see https://github.com/dmacvicar/terraform-provider-libvirt/issues/660
      host    = self.network_interface[0].addresses[0]
      timeout = "1h"
    }
  }
}

