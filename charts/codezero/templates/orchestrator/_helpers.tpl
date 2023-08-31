{{- if ne .Release.Namespace "codezero" }}
{{- fail "The Codezero orchestrator has to be installed in codezero namespace" }}
{{- end }}

{{- define "orchestrator.name" -}}
orchestrator
{{- end }}

{{/*
Common labels
*/}}
{{- define "orchestrator.labels" -}}
{{ include "codezero.labels" . }}
{{ include "orchestrator.selectorLabels" . }}
{{- with .Values.orchestrator.labels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "orchestrator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "orchestrator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "orchestrator.podLabels" -}}
{{ include "codezero.podLabels" . }}
{{ include "orchestrator.selectorLabels" . }}
{{- with .Values.orchestrator.podLabels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "orchestrator.podAnnotations" -}}
{{ include "codezero.podAnnotations" . }}
{{- with .Values.orchestrator.podAnnotations }}
{{ . | toYaml }}
{{- end }}
{{- end }}
