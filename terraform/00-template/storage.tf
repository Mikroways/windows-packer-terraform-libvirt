resource "libvirt_volume" "windows-11-base" {
  name   = var.base_windows_tpl_name
  pool   = var.pool
  source = var.windows_base_template
  format = "qcow2"
  lifecycle {
    prevent_destroy = true
  }
}

