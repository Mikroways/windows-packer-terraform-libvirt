variable "provider_url" {
  default     = "qemu:///system"
  description = "Libvirt URL to use"
}

variable "pool" {
  default     = "default"
  description = "Libvirt storage pool where volumes will be created"
}

variable "windows_base_template" {
  description = "Input qcow2 image created with packer as explained outside this folder"
}

variable "base_windows_tpl_name" {
  default     = "windows-11-base.qcow2"
  description = "Name of above option when uploaded as a libvirt volume to be used as template"
}

