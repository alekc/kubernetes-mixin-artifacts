# Kubernetes Mixin Artifacts

This repository provides pre-packaged artifacts from the [Kubernetes Mixin](https://github.com/kubernetes-monitoring/kubernetes-mixin) project, making it easy to load Grafana dashboards directly via a Helm chart.

## Scope
- Download and extract Kubernetes Mixin releases.
- Make dashboards and alerts available for use in Helm-based deployments.
- Automate updates to the mixin version using RenovateBot.

## Usage
Artifacts in the `release/$VERSION` directory can be consumed by the official Grafana Helm chart (`grafana/grafana`) using its `dashboards` value block. This chart automatically converts the entries under `dashboards:` into appropriately labeled ConfigMaps for Grafana to load.

### Using Grafana Helm Chart `dashboards:`
The chart supports several sources for dashboards (inline JSON, local files, Grafana.com IDs, remote URLs, etc.). Below is the structure (simplified from the chart documentation):

```yaml
dashboards: {}
  # default:
  #   some-dashboard:
  #     json: |
  #       $RAW_JSON
  #   custom-dashboard:
  #     file: dashboards/custom-dashboard.json
  #   prometheus-stats:
  #     gnetId: 2
  #     revision: 2
  #     datasource: Prometheus
  #   local-dashboard:
  #     url: https://example.com/repository/test.json
  #     curlOptions: "-sLf"
  #     token: ''
  #   local-dashboard-base64:
  #     url: https://example.com/repository/test-b64.json
  #     token: ''
  #     b64content: true
  #   local-dashboard-gitlab:
  #     url: https://example.com/repository/test-gitlab.json
  #     gitlabToken: ''
  #   local-dashboard-bitbucket:
  #     url: https://example.com/repository/test-bitbucket.json
  #     bearerToken: ''
  #   local-dashboard-azure:
  #     url: https://example.com/repository/test-azure.json
  #     basic: ''
  #     acceptHeader: '*/*'
```

### Adding Kubernetes Mixin Dashboards
1. Run `./download.sh` so that `release/$VERSION/dashboards/*.json` exists (e.g. `release/1.4.0/dashboards/`).
2. Copy (or symlink / vendor) those dashboard JSON files into your Helm chart directory (e.g. place them under `https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/`). The Grafana chart processes files referenced via `file:` relative to the chart root.
3. In your Grafana chart values, list each dashboard under a provider key (e.g. `kubernetes-mixin:`). Example with a few dashboards:

```yaml
# Minimal example
dashboards:
  kubernetes-mixin:
    apiserver:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/apiserver.json
    controller-manager:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/controller-manager.json
    kubelet:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/kubelet.json
```

#### Full Dashboard Inventory (version 1.4.0)
All JSON files currently present under `release/1.4.0/dashboards/`:
- apiserver.json
- cluster-total.json
- controller-manager.json
- k8s-resources-cluster.json
- k8s-resources-namespace.json
- k8s-resources-node.json
- k8s-resources-pod.json
- k8s-resources-windows-cluster.json
- k8s-resources-windows-namespace.json
- k8s-resources-windows-pod.json
- k8s-resources-workload.json
- k8s-resources-workloads-namespace.json
- k8s-windows-cluster-rsrc-use.json
- k8s-windows-node-rsrc-use.json
- kubelet.json
- namespace-by-pod.json
- namespace-by-workload.json
- persistentvolumesusage.json
- pod-total.json
- proxy.json
- scheduler.json
- workload-total.json

#### Complete Values YAML Example
Below is a verbose example adding every mixin dashboard. You can trim to what you actually need:

```yaml
dashboards:
  default:
    apiserver:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/apiserver.json
    cluster-total:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/cluster-total.json
    controller-manager:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/controller-manager.json
    k8s-resources-cluster:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-cluster.json
    k8s-resources-namespace:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-namespace.json
    k8s-resources-node:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-node.json
    k8s-resources-pod:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-pod.json
    k8s-resources-windows-cluster:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-windows-cluster.json
    k8s-resources-windows-namespace:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-windows-namespace.json
    k8s-resources-windows-pod:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-windows-pod.json
    k8s-resources-workload:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-workload.json
    k8s-resources-workloads-namespace:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-resources-workloads-namespace.json
    k8s-windows-cluster-rsrc-use:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-windows-cluster-rsrc-use.json
    k8s-windows-node-rsrc-use:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/k8s-windows-node-rsrc-use.json
    kubelet:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/kubelet.json
    namespace-by-pod:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/namespace-by-pod.json
    namespace-by-workload:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/namespace-by-workload.json
    persistentvolumesusage:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/persistentvolumesusage.json
    pod-total:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/pod-total.json
    proxy:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/proxy.json
    scheduler:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/scheduler.json
    workload-total:
      url: https://raw.githubusercontent.com/alekc/kubernetes-mixin-artifacts/refs/heads/master/release/1.4.0/workload-total.json
```

Notes:
- Keys under `kubernetes-mixin:` can be renamed to suit your naming convention; they become dashboard titles only if the JSON itself lacks a title.
- Keep file paths relative to the chart root.
- Remove dashboards you do not plan to use to reduce ConfigMap size.

If you prefer inline JSON, replace a `file:` stanza with `json: |` and paste its contents. For large sets, file references are recommended.

### Automating Dashboard Entries
The `values.yaml` file itself cannot use Helm templating to auto-enumerate files. Options to automate:
- Pre-generate the dashboards section using a script prior to `helm upgrade --install`.
- Maintain a small helper script (e.g. `scripts/gen-dashboards.sh`) that scans `release/$VERSION/dashboards` and outputs YAML you can append to `values.yaml`.
- Package this repository’s `release/$VERSION/dashboards` directory directly inside a reusable Helm library chart and update `values.yaml` only when versions change (Renovate will help bump `VERSION`).

Once applied, the Grafana chart creates ConfigMaps labeled for dashboard discovery; no manual ConfigMap crafting is needed.

### Alerts / Recording Rules
Prometheus alerting/recording rules from the mixin (often under `alerts` or `rules`) are not consumed by Grafana directly. They should be applied via the kube-prometheus-stack chart or your Prometheus Operator setup. You can create a separate ConfigMap or PrometheusRule manifest using a similar file iteration approach:

```yaml
{{- $version := "1.4.0" }}
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: kubernetes-mixin-rules
spec:
  groups:
{{- range $path, $_ := .Files.Glob (printf "release/%s/alerts/*.yaml" $version) }}
{{ .Files.Get $path | indent 4 }}
{{- end }}
```

## How It Works
- Run `download.sh` to fetch and extract the desired mixin version.
- The extracted dashboards and alerts are placed in the corresponding `release/$VERSION` directory.
- Reference these files in your Helm chart as shown above.

## Updating Mixin Version
This repository uses RenovateBot to automatically raise a pull request when a new Kubernetes Mixin release is available. The `VERSION` in `download.sh` will be updated, and new artifacts will be downloaded.

## License
See the original [Kubernetes Mixin](https://github.com/kubernetes-monitoring/kubernetes-mixin) repository for license details.
