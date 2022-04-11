variable "provider_url" {
  default     = "qemu:///system"
  description = "Libvirt URL to use"
}

variable "bridge" {
  default     = "virbr0"
  description = "Which bridge network to use from libvirt main host"
}

variable "pool" {
  default     = "default"
  description = "Libvirt storage pool where volumes will be created"
}

variable "base_windows_tpl_name" {
  default     = "windows-11-base.qcow2"
  description = "Name of above option when uploaded as a libvirt volume to be used as template"
}

variable "prefix" {
  default     = "windows-11"
  description = "Prefix to use for every libvirt resource created by terraform"
}

variable "winrm_username" {
  default     = "mikroways"
  description = "Username to be created as admin"
}

variable "winrm_password" {
  sensitive = true
  # set the administrator password.
  # NB the administrator password will be reset to this value by the cloudbase-init SetUserPasswordPlugin plugin.
  # NB this value must meet the Windows password policy requirements.
  #    see https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements
  default     = "M1kr0w4ys"
  description = "Password of winrm_username. Please change default value"
}

variable "timezone" {
  default     = "America/Argentina/Buenos_Aires"
  description = "Timezone"
}

variable "disk_size" {
  default     = 80
  description = "Size of main disk in GB"
}

variable "cpu" {
  default     = 2
  description = "Number of virtual CPU"
}

variable "memory" {
  default     = 4096
  description = "Memory in GB"
}
