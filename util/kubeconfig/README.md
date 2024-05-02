# Inject cluster's settings into your kubeconfig

The script is provided for your convenience to automatically setup your kubeconfig file with `cikube` cluster's settings:

* Grab `cikube OIDC client secret` value from your secret management store
* Execute `cikube-kubeconfig-merge` script: `./util/kubeconfig/cikube-kubeconfig-merge --oidc-client-secret <cikube OIDC client secret>`

If your prefered approach is to use different kubeconfig files, copy `cikube-kubeconfig.yml` to a location of your choice and replace `--oidc-client-secret` value with a proper one.
