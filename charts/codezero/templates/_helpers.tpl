{{- define "codezero.name" -}}
codezero
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "codezero.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "codezero.labels" -}}
helm.sh/chart: {{ include "codezero.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: codezero
{{- with .Values.labels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "codezero.podLabels" -}}
{{ include "codezero.labels" . }}
{{- with .Values.podLabels }}
{{ . | toYaml }}
{{- end }}
{{- end }}

{{/*
Pod annotations
*/}}
{{- define "codezero.podAnnotations" -}}
{{- with .Values.podAnnotations }}
{{ . | toYaml }}
{{- end }}
{{- end }}
