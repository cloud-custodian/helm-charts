{{- define "c7n_kube.app_name" }}c7n_kube{{ end }}

{{- define "c7n_kube.pod_app_label" }}c7n_kube{{ end }}

{{- define "c7n_kube.pod_name" }}c7n_kube{{ end }}

{{- define "c7n-kube.policies-configmap-name"}}c7n_kube_policies{{ end }}

{{- define "c7n-kube.common-labels" }}
{{ include "c7n-kube.pod-match-labels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: c7n
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end }}

{{- define "c7n-kube.pod-match-labels" }}
app.kubernetes.io/component: controller
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: c7n_kube
{{- end }}
