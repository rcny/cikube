# cikube Kubernetes Platform

`cikube` is the opinionated Kubernetes setup specifically tailored to execute Rust-based CI workloads originating from GitHub Actions.

![cikube logo](https://i.imgur.com/eWPaXxc.png)

## Main features

* Clusters treated as cattle
* Could work anywhere
* Reproducible as every component is versioned and pinned
* Self-contained and doesn't depend on anything outside of a cluster

## Components list

The following lists describe the components that are available in each corresponding category.

#### Major cluster components

| Component | Version |
|---|---|
| Actions Runner Controller | 0.9.1 |
| GitHub Actions Runner | 2.316.1 |
| Grafana Alloy | 1.0.0 |
| K3s | 1.28.7+k3s1 |

#### Important node components

| Component | Version |
|---|---|
| Debian | 12.5 |
| Kernel | 6.1.76 / 5.10.209 |
| nerdctl | 1.7.4 |

#### Important manager components

| Component | Version |
|---|---|
| Alpine | 3.19.1 |
| Ansible | 9.2.0 (2.16.3) |
| gcloud | 474.0.0 |
| Helm | 3.13.3 |
| k3sup | 0.13.5 |
| Packer | 1.9.5 |
| SOPS | 3.8.1 |
| Terraform | 1.6.6 |

## Usage

🏗️
Currently the repository is structured as a monorepo. <...>
🏗️

## Supported providers

`cikube` is designed to be provider-agnostic. The platform is [k3s-based](https://k3s.io), so it can be run on anything from static virtual machines to bare metal, on top of IaaS providers or even just a bunch of Raspberry Pi devices. However, the following providers are officially supported.

| Provider | Support status |
|---|---|
| Google Cloud | Beta |

## Important information

#### High availability

`cikube` clusters are deployed in a single master mode on multiple purposes:
* Avoid the need to manage dedicated HA etcd clusters
* Avoid the need to use etcd at all
* Keep the control plane cost low
* High availability and redundancy in production should be achieved with multiple clusters setup. In the event of a control plane failure, CI workloads are automatically migrated to another cluster
* Any `cikube` cluster can be automatically recreated from scratch. There are no manual actions required to provision the cluster (well, except for starting a pipeline/workflow), everything is automated, and all Kubernetes resources are managed using an IaC approach

#### Cost efficiency

`cikube` is engineered with cost-effectiveness in mind. The reference Google Cloud setup utilizes MIGs and spot instances to optimize expenses. MIGs employ predictive autoscaling ([proprietary Google Cloud ML technique](https://cloud.google.com/compute/docs/autoscaler/predictive-autoscaling)), allowing the cluster to scale down to zero worker nodes during periods of inactivity and scale up automatically in anticipation of expected CI workload amount. This proactive scaling approach, which relies on forecasting potential CI workloads ahead of time, cannot be achieved with basic EKS/GKE/AKS setups without incorporating specialized time series forecasting methods.

This model is regarded as the most cost-effective strategy to run e.g. Polkadot SDK CI on scale without involving any dedicated infrastructure.

#### Topology

The control plane node should be a persistent machine because it's used to run the control plane components and other bundled controllers, along with additional supporting solutions. Worker nodes are used to run CI workloads and can be ephemeral. The control plane node doesn't execute any CI workloads. Additionally, observability-related DaemonSets, such as Grafana Alloy, are deployed on both control plane and worker nodes.

#### Observability

Clusters have Grafana Alloy installed, which collects both logs and metrics from cluster entities and nodes' `systemd` service units. Logs are collected from every available pod in a cluster and every available `systemd` unit on a node, logs are then sent to a Loki-compatible ingest API endpoint. Metrics are collected from any cluster `ServiceMonitor` or `PodMonitor` CRD and are sent to an external Prometheus's `remote_write` compatible API. Note that this is optional as you can run `cikube` without any observability-related components if needed.

`cikube` clusters don't have any persistent logs or metrics storage.

#### Where is Argo (or Flux)?

These are special purpose clusters. They are not intended to be used for anything other than running CI workloads. That's why e.g. Argo is not installed there, as it only adds complexity. All Kubernetes resources with appropriate Helm releases are managed either as via Terraform declarations or via bundled [Helm Controller](https://github.com/k3s-io/helm-controller)'s CRDs.

#### Attribution

This repository is based on [paritytech/cikube](https://github.com/paritytech/cikube), which is authored by Parity Technologies and licensed under the Apache License 2.0.

#### License

This project is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for more information.
