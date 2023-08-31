{{- if ne .Release.Namespace "codezero" }}
{{- fail "The Codezero system has to be installed in codezero namespace" }}
{{- end }}

{{- define "system.name" -}}
system
{{- end }}

{{/*
Common labels
*/}}
{{- define "system.labels" -}}
{{ include "codezero.labels" . }}
{{ include "system.selectorLabels" . }}
{{- with .Values.system.labels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "system.selectorLabels" -}}
app.kubernetes.io/name: {{ include "system.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "system.podLabels" -}}
{{ include "codezero.podLabels" . }}
{{ include "system.selectorLabels" . }}
{{- with .Values.system.podLabels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "system.podAnnotations" -}}
{{ include "codezero.podAnnotations" . }}
{{- with .Values.system.podAnnotations }}
{{ . | toYaml }}
{{- end }}
{{- end }}
