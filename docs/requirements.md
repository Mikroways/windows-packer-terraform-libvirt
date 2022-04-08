# Requirements

Install required software, this is the ones descibed above, and prepare your
machine to work with libvirt and kvm. If you are working with a debian based os,
you shall install the following packages:

```
sudo apt update
sudo apt install cpu-checker
```

The verify your machine supports virtualization:

```
kvm-ok
```

If KVM acceleration can be used, then proceed installing teh following:

```
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients \
  bridge-utils virtinst virt-viewer
```

Finally, you shall add your current user as a **libvirt group member**:

```
sudo usermod -aG libvirt $USER
sudo usermod -aG kvm $USER
```

> Exit and restart your session if you will just start working with libvirt

The last step is **required for qemu to work without security constraints**. At
least on debian based OS, you will need to ensure the `security_driver` is set
to **`none`** inside `/etc/libvirt/qemu.conf`:

```
security_driver = "none"
```

> Without changing this option, virtual machines created within terraform will
> fail to create.

## Recommended extra packages

If you also install the following package:

```
apt install libnss-libvirt
```

The operating system could resolve virtual machines names to ip address.
So if you would like to enable this feature, you will also need to edit
`/etc/nsswitch.conf` changing hosts definition like this:

```
hosts:  files libvirt libvirt_guest mdns4_minimal [NOTFOUND=return] dns mymachines
```

Now you can ping or ssh vms using it's virtual machine libvirt name. You can
list vms using `virsh list`.

