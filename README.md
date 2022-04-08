# Creating a windows vm using IaC

This repo will introduce how to provision a windows 11 vm using same tools we
are used to work with linux vms. This example will guide us on how to work with:

* [Packer](https://www.packer.io/): to create a windows template ready ti be provisioned with terraform
* [Terraform](https://www.terraform.io/): to create a new vm from created template using libvirt
* [Ansible](https://www.ansible.com/): to install some packages and tune OS

To completely install all requirements [follow these detailed
instructions](docs/requirements.md)

## Create packer templates

To create a windows packer template, we are going to use [github
rgl/windows-vagrant repository](https://github.com/rgl/windows-vagrant). It
simplifies all the complexities to prepare a window box. 

The following commands will prepare a template for windows 11:

```
git clone https://github.com/rgl/windows-vagrant packer/
cd packer
```

When inside packer directory, you can follow repository documentation, but if
you are anxious to start virtualising keep going:

```
make help
```

Will list all available templates for each virtualisation platform. We are going
to use libvirt, so:

```
make --dry-run build-windows-11-21h2-libvirt
```

Will list all commands that will be run. If you would like to change, for
example some variable of each packer hcl file, you are going to need to run this
comman manually. But you can do something like:

```
make --dry-run build-windows-11-21h2-libvirt \
  | sed 's/packer build/packer build --var-file=windows-11-customizations.hcl/' \
  > my-packer-helper.sh
chmod +x my-packer-helper.sh
```

And add some options as you prefer. For example, you can pass new variable
values, for example to change windows language to spanish:

```
cat > windows-11-customizations.hcl <<EOF
iso_url = "https://software-download.microsoft.com/download/sg/888969d5-f34g-4e03-ac9d-1f9786c66749/22000.318.211104-1236.co_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_es-es.iso"
iso_checksum = "sha256:58CAC6ABBE52EAD3184CF4CFEFADE487C0E11BBFF4D7AC1EFE6D1E238DD43971"
EOF
```

Then run your `./my-packer-helper.sh`

> This will not work with provided unattended file, so check this file if trying
> to change installation language.

### During packer is working

If you see packer logs, you will notice there is a vnc URL like
`qemu.windows-11-21h2-amd64: vnc://127.0.0.1:5948`. This means that you can
attach through vnc, and check installation process is working.

## Terraform

Once a libvirt template is created using packer, we are going to create a new
machine using terraform. The [`terraform/`](./terraform) folder will create a
new base template image, and then create a windows virtual machine from this
template.

TODO

## Ansible

TODO
