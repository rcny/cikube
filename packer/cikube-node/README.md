# `cikube-node`

`cikube-node` contains the Packer configuration and Ansible playbooks for building the base node image used in `cikube` clusters.

### Specifics

* A generic image based on Debian 12 with kernel 6.x is built first
* The generic image is then used as a base to create a second image with kernel 5.x

The Ansible provisioner handles installing packages, configuring the system, and laying down K3s and `cikube` tools. The playbooks for the provisioner use roles from the `parity.cikube` collection only, which resides in the `ansible/parity.cikube` directory of this project.

### Notes

- Increment the image version in `common.auto.pkrvars.hcl` before building an updated image
