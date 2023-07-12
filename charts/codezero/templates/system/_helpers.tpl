{{- if ne .Release.Namespace "codezero" }}
{{- fail "The CodeZero system has to be installed in codezero namespace" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "system.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if hasSuffix .Values.system.name  $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $name .Values.system.name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "system.fullname" -}}
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
{{- if hasSuffix .Values.system.name $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $name .Values.system.name | trunc 63 | trimSuffix "-" }}
{{- end }}
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

{{/*
Create the name of the service account to use
*/}}
{{- define "system.serviceAccountName" -}}
{{- if .Values.system.serviceAccount.create }}
{{- default (include "system.fullname" .) .Values.system.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.system.serviceAccount.name }}
{{- end }}
{{- end }}
