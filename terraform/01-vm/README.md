# Creating a windows vm using terraform

This folder contains terraform version requirements, and some input variables
you may want to change.

First of all, read all available [inputs](#inputs) and proceed with terraform as
follows.

To start a new vm, first initialize terraform so it will get all required
modules:

```
terraform  init
```

After, run:

```
terraform plan
```

And if everything is ok for you, run:

```
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | >= 0.6.14 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.1.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_windows_tpl_name"></a> [base\_windows\_tpl\_name](#input\_base\_windows\_tpl\_name) | Name of above option when uploaded as a libvirt volume to be used as template | `string` | `"windows-11-base.qcow2"` | no |
| <a name="input_bridge"></a> [bridge](#input\_bridge) | Which bridge network to use from libvirt main host | `string` | `"virbr0"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of virtual CPU | `number` | `2` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of main disk in GB | `number` | `80` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory in GB | `number` | `4096` | no |
| <a name="input_pool"></a> [pool](#input\_pool) | Libvirt storage pool where volumes will be created | `string` | `"default"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to use for every libvirt resource created by terraform | `string` | `"windows-11"` | no |
| <a name="input_provider_url"></a> [provider\_url](#input\_provider\_url) | Libvirt URL to use | `string` | `"qemu:///system"` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone | `string` | `"America/Argentina/Buenos_Aires"` | no |
| <a name="input_winrm_password"></a> [winrm\_password](#input\_winrm\_password) | Password of winrm\_username. Please change default value | `string` | `"M1kr0w4ys"` | no |
| <a name="input_winrm_username"></a> [winrm\_username](#input\_winrm\_username) | Username to be created as admin | `string` | `"mikroways"` | no |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
