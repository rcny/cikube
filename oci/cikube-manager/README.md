# Manager's image

*a.k.a. `cikube`'s management image*

### Description

This image is used to run everything in the `cikube` CI, except for the jobs where OCI images are built via Buildah, since the correct way to run Buildah here is to use the original upstream Red Hat image.

### Public location

This image is available publicly on [Quay.io](https://quay.io/polkadot-infra/cikube-manager).

### Notes

* The resulting image is tagged and pushed with two tags: `latest` and `v<DATESTAMP>` (e.g. `v19700101`).
