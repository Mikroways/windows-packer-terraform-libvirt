# Creating a windows vm using IaC

This repo will introduce how to provision a windows 11 vm using same tools we
are used to work with linux vms. This example will guide us on how to work with:

* [Packer](https://www.packer.io/): to create a windows template ready ti be provisioned with terraform
* [Terraform](https://www.terraform.io/): to create a new vm from created template using libvirt
* [Ansible](https://www.ansible.com/): to install some packages and tune OS

To completely install all requirements [follow these detailed
instructions](docs/requirements.md)

It's important to have above 30GB of free space, windows templates are really
big and every process considered requires lot's of space.

## Create packer templates

To create a windows packer template, we are going to use [github
rgl/windows-vagrant repository](https://github.com/rgl/windows-vagrant). It
simplifies all the complexities to prepare a window box. 

The following commands will prepare a template for windows 11:

```
git clone https://github.com/rgl/windows-vagrant packer/
cd packer
```
> Note that cloning this repo into `packer/` sub folder into this repo will be
> ignored.

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
> If everything looks good to yo, proceed without `--dry-run`


### In case you want to change some packer options

If you would like to change, for example some variables of each packer hcl file,
you are going to need to run some helper script. The next example shows how
create this helper script, adding an extra `-var-file` option:

```
make --dry-run build-windows-11-21h2-libvirt \
  | sed 's/packer build/packer build --var-file=windows-11-customizations.hcl/' \
  > my-packer-helper.sh
chmod +x my-packer-helper.sh
```

For example, you can pass new variable values, to change windows language to
spanish:

```
cat > windows-11-customizations.hcl <<EOF
iso_url = "https://software-download.microsoft.com/download/sg/888969d5-f34g-4e03-ac9d-1f9786c66749/22000.318.211104-1236.co_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_es-es.iso"
iso_checksum = "sha256:58CAC6ABBE52EAD3184CF4CFEFADE487C0E11BBFF4D7AC1EFE6D1E238DD43971"
EOF
```

Then run your `./my-packer-helper.sh`

> This will not work with provided unattended file, so check this file if trying
> to change installation language.

### Creating a Vagrant Box or not

Packer repository will create a vagrant box and erase intermediate artifacts,
this is a qcow2 windows template ready to be used by terraform. If you are only
working with terraform, it may be useful not to wait for a Vagrant box creation,
so this step can be avoided removing the post-processor section inside
`windows-11-21h2.pkr.hcl`.

If you prefer to keep a Vagrant box image and opt to use both, you can edit
section and set `keep_input_artifact` to true.

The last option, is to extract qcow2 image from Vagrant box:

```
tar xfz windows-11-21h2-amd64-libvirt.box box.img
```

### During packer is working

If you see packer logs, you will notice there is a vnc URL like
`qemu.windows-11-21h2-amd64: vnc://127.0.0.1:59XX`. This means that you can
attach through vnc, and check installation process is working.

## Terraform

Once a libvirt template is created using packer, we are going to create a new
machine using terraform. The [`terraform/`](./terraform) folder will create a
new base template image, and then create a windows virtual machine from this
template. Follow this folder documentation.

## Ansible

TODO
