{{- if ne .Release.Namespace "codezero" }}
{{- fail "The Codezero LB has to be installed in codezero namespace" }}
{{- end }}

{{- define "lb.name" -}}
loadbalancer
{{- end }}

{{/*
Common labels
*/}}
{{- define "lb.labels" -}}
{{ include "codezero.labels" . }}
{{ include "lb.selectorLabels" . }}
{{- with .Values.lb.labels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "lb.podLabels" -}}
{{ include "codezero.podLabels" . }}
{{ include "lb.selectorLabels" . }}
{{- with .Values.lb.podLabels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "lb.podAnnotations" -}}
{{ include "codezero.podAnnotations" . }}
checksum/configmap: {{ include (print .Template.BasePath "/lb/configmap.yaml") . | sha1sum }}
{{- with .Values.lb.podAnnotations }}
{{ . | toYaml }}
{{- end }}
{{- end }}
