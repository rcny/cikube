# `k3s_base`

`k3s_base` is the Ansible role that installs K3s on a node and pre-configures it for later kickstart via a preferred method (e.g. cloud-init).

### Specifics

The role doesn't actually start the cluster. While you have the necessary binaries, configuration barebones, and systemd units, you still need to actually start the relevant services (i.e., server or agent) and dynamically provide the necessary configuration parts, i.e., you bootstrap at runtime using your chosen method.

### Notes

- This role works with Debian 12 and hasn't been tested with other Debian versions or with any Debian derivatives
- This role depends on the `cikube_tools` Ansible role in this collection. It doesn't matter if the `cikube_tools` role is run before or after the `k3s_base` role, as the `cikube_tools` scripts are used by the `k3s_base` role at runtime
- Currently `x86_64` architecture is supported. `arm64` support will be added in the future
- Relevant Ansible roles for bootstrapping and managing a cluster via Ansible may become available in the future
