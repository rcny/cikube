# cikube Terraform module for Google Cloud

This module allows you to create and configure a `cikube` reference cluster setup for Google Cloud projects.

## Inputs

### General

| Name                         | Description                                                | Type           | Default         | Required |
| ---------------------------- | ---------------------------------------------------------- | -------------- | --------------- | -------- |
| `cluster_name`               | Name of the cikube cluster                                 | `string`       |                 | Yes      |
| `machine_type`               | Machine type for the server instance                       | `string`       | `c3d-highcpu-4` | No       |
| `network`                    | VPC network to deploy resources in                         | `string`       |                 | Yes      |
| `region`                     | Google Cloud region                                        | `string`       |                 | Yes      |
| `server_external_ip_enabled` | Whether to use external IP address for the server instance | `bool`         | `true`          | No       |
| `server_image`               | Source image for the server template                       | `string`       |                 | Yes      |
| `server_tags`                | List of custom tags to apply to the server instance        | `list(string)` | `[]`            | No       |
| `server_zone`                | Google Cloud zone to deploy server in                      | `string`       |                 | Yes      |
| `subnetwork`                 | VPC subnetwork to deploy resources in                      | `string`       |                 | Yes      |

### Agent specific

| Name                     | Description                                                | Type           | Default  | Required |
| ------------------------ | ---------------------------------------------------------- | -------------- | -------- | -------- |
| `boot_disk_size`         | Size of the boot disk                                      | `number`       | `20`     | No       |
| `boot_disk_type`         | Type of the boot disk                                      | `string`       | `pd-ssd` | No       |
| `image`                  | Source image for the agent template                        | `string`       |          | Yes      |
| `machine_type`           | Machine type for an each agent instance                    | `string`       |          | Yes      |
| `external_ip_enabled`    | Whether to use external IP address for the agent instances | `bool`         | `true`   | No       |
| `opts`                   | Additional options for cikube-init                         | `string`       |          | No       |
| `scaler_cooldown_period` | Cooldown period for the MIG's autoscaler                   | `number`       | `240`    | No       |
| `scaler_cpu_utilization` | Target CPU utilization for the autoscaler                  | `number`       | `0.5`    | No       |
| `scaler_max_replicas`    | Maximum number of agents in the pool                       | `number`       | `10`     | No       |
| `scaler_min_replicas`    | Minimum number of agents in the pool                       | `number`       | `0`      | No       |
| `scaler_predictive`      | Whether to use predictive autoscaling                      | `bool`         | `true`   | No       |
| `spot`                   | Whether to use spot instances                              | `bool`         | `false`  | No       |
| `ssd_count`              | Number of local SSD disks to attach                        | `number`       | `2`      | No       |
| `tags`                   | List of custom tags to apply to the agent                  | `list(string)` | `[]`     | No       |
| `zones`                  | Actual Google Cloud zones to deploy agents in              | `list(string)` |          | Yes      |

## Outputs

| Name    | Description                                  |
| ------- | -------------------------------------------- |
| `name`  | The name of the cluster                      |
| `token` | The token used to join agents to the cluster |

## Example

🏗️
<...>
🏗️
