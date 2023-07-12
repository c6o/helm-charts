{{- if ne .Release.Namespace "codezero" }}
{{- fail "The CodeZero LB has to be installed in codezero namespace" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "lb.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if hasSuffix .Values.lb.name  $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $name .Values.lb.name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lb.fullname" -}}
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
{{- if hasSuffix .Values.lb.name $name }}
{{- $name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" $name .Values.lb.name | trunc 63 | trimSuffix "-" }}
{{- end }}
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

{{/*
Create the name of the service account to use
*/}}
{{- define "lb.serviceAccountName" -}}
{{- if .Values.lb.serviceAccount.create }}
{{- default (include "lb.fullname" .) .Values.lb.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.lb.serviceAccount.name }}
{{- end }}
{{- end }}
