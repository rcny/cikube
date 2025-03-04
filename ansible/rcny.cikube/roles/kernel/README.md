# `kernel`

`kernel` is the Ansible role to install and pin specific Kernel version for the `cikube` node image. Currently it's used as one of the steps during the `cikube` node image creation process.

### Specifics

Note that the role is quite strict in how it handles kernel pinning, and it's highly recommended to use it only in the context of `cikube` node image creation or something similar.

### Notes

* You need Debian 12 to use this role. It has not been tested on other Debian versions or with any Debian derivatives (e.g. Ubuntu)
* Currently `x86_64` architecture is supported. `arm64` support will be added in the future
