# Creating a template for libvirt

This folder contains a terraform resource to upload a libvirt qcow2 file as a
volume to be used after as base image for virtual machines.

The only requirement is that you specify required variable as input var, for
example with `../../packer/box.img` as explained in main README.

```
terraform  init
terraform apply -var="windows_base_template=../../packer/box.img"
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_libvirt"></a> [libvirt](#requirement\_libvirt) | >= 0.6.14 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_windows_base_template"></a> [windows\_base\_template](#input\_windows\_base\_template) | Input qcow2 image created with packer as explained outside this folder | `any` | n/a | yes |
| <a name="input_base_windows_tpl_name"></a> [base\_windows\_tpl\_name](#input\_base\_windows\_tpl\_name) | Name of above option when uploaded as a libvirt volume to be used as template | `string` | `"windows-11-base.qcow2"` | no |
| <a name="input_pool"></a> [pool](#input\_pool) | Libvirt storage pool where volumes will be created | `string` | `"default"` | no |
| <a name="input_provider_url"></a> [provider\_url](#input\_provider\_url) | Libvirt URL to use | `string` | `"qemu:///system"` | no |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
