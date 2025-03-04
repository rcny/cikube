# `bundle_oci_image`

`bundle_oci_image` is the Ansible role for downloading specific OCI (i.e. Docker) images to your host's file system. In terms of the `cikube` node image creation process, the role bakes the most commonly used "fat" OCI images into the node image. The role works with containerd-based setups only.

### Specifics

This role employs a specialized containerd setup to pull and store OCI images directly into the containerd content store used by K3s. This approach ensures that the images are immediately available to Kubernetes pods without the need for image pull operations at pod startup time.

### Why do you install an additional containerd?

There is no other way to **unpack** and bake images **straight into containerd content store**. Daemonless approaches (e.g. with Skopeo) are not possible, as there is no ready-to-use tooling available that downloads the image from the remote registry and unpacks it in the containerd content store format (e.g. Skopeo doesn't support this explicitly). The containerd instance bundled with K3s is tightly integrated, it cannot be started without starting other K3s components as well. To avoid interfering with K3s operations, and to maintain a clear separation of concerns (especially during the `cikube` node image creation process), a dedicated containerd instance is used.

### Notes

* After the generic CI image update, you must rebuild the `cikube` node image so that it would contain the actual version of your CI image
* Define the list of OCI images to bundle in the `cikube_oci_images_to_bundle` variable (see `defaults/main.yml`)
* You must have `nerdctl` in your PATH to use this role
* The additional containerd **should only be used** for OCI image management operations, so it's managed by this role too rather than a dedicated one
