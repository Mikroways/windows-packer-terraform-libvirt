# Why two subdirectories?

There are two folders because:

* **[`00-template/`](./00-template):** uploads packr image as libvirt template.
* **[`01-vm/`](./01-vm):** creates a new vm from libvirt template using
  cloudinit.

Each folder has its own readme. After creating a new vm, you could connect to it
using:

* virt-viewer
* `ssh mikroways@windows-11`
