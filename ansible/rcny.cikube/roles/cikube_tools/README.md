# `cikube_tools`

`cikube_tools` is the Ansible role that installs the necessary tools for bootstrapping and tuning a K3s cluster.

### Specifics

The role installs the following tools:

- `cikube-init` - cluster bootstrap helper
- `cikube-server-taint` - taint the server with `node-role.kubernetes.io/master:NoSchedule` gracefully
- `cikube-storage-ln` - moves K3s's containerd data root+state and K3s's Kubelet data root to a non-rootfs using symlinks

### Notes

- This role depends on the `k3s_base` Ansible role in this collection. The scripts are expected to work in the context of the `k3s_base` role
