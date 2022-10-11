{{- define "c7n_kube.app_name" }}c7n_kube{{ end }}

{{- define "c7n_kube.pod_app_label" }}c7n_kube{{ end }}

{{- define "c7n_kube.pod_name" }}c7n_kube{{ end }}

{{- define "c7n-kube.policies-configmap-name"}}c7n_kube_policies{{ end }}

{{- define "c7n-kube.common-labels" }}
app.kubernetes.io/component: AdmissionController
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: c7n_kube.app_name
app.kubernetes.io/part-of: c7n
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end }}

{{- define "c7n-kube.template-map" }}
{{ $ctx := .ctx }}
{{- range $k, $v := .data }}
{{ tpl $k $ctx }}: {{ tpl $v $ctx }}
{{- end }}
{{- end }}

{{- define "c7n-kube.pod-match-labels" }}
{{ include "c7n-kube.template-map" ( dict "data" .Values.pod.labels "ctx" . ) }}
{{ include "c7n-kube.common-labels" . }}
{{- end }}
