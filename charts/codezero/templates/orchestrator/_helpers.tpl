{{/*
Expand the name of the chart.
*/}}
{{- define "orchestrator.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if hasSuffix .Values.orchestrator.name  $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $name .Values.orchestrator.name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "orchestrator.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if .Values.fullnameOverride }}
{{- $name = .Values.fullnameOverride }}
{{- else }}
{{- if contains $name .Release.Name }}
{{- $name = .Release.Name }}
{{- else }}
{{- $name = printf "%s-%s" .Release.Name $name }}
{{- end }}
{{- end }}
{{- if hasSuffix .Values.orchestrator.name $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $name .Values.orchestrator.name | trunc 63 | trimSuffix "-" }}
{{- end }}
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
{{- include "codezero.podLabels" . }}
{{- include "orchestrator.selectorLabels" . }}
{{- with .Values.orchestrator.podLabels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "orchestrator.podAnnotations" -}}
{{- include "codezero.podAnnotations" . }}
checksum/configmap: {{ include (print .Template.BasePath "/orchestrator/configmap.yaml") . | sha1sum }}
{{- with .Values.orchestrator.podAnnotations }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "orchestrator.serviceAccountName" -}}
{{- if .Values.orchestrator.serviceAccount.create }}
{{- default (include "orchestrator.fullname" .) .Values.orchestrator.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.orchestrator.serviceAccount.name }}
{{- end }}
{{- end }}