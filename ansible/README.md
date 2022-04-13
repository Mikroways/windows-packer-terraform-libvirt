# Ansible windows vm provisioning

This playbook is fully inspired by [Alexander Nabokikh windows playbook]
(https://github.com/AlexNabokikh/windows-playbook/). It first upgrade windows,
then install some packages, uninstall unwanted software and finally enable wsl.

You can run this playbook after a windows vm is created as explained in main
README:

```
ansible-playbook -i inventory.yml playbook.yml
```
