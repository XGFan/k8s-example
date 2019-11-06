{{/* vim: set filetype=mustache: */}}


{{- define "app.name" -}}
     {{ default .Release.Name .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "app.fullname" -}}
     {{- printf "%s-%s" (include "app.name" .) .Values.image.tag  | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.project" -}}
    {{-  .Values.project.name  -}}
{{- end -}}

{{- define "app.env" -}}
    {{ default "dev" .Release.Namespace }}
{{- end -}}


{{- define "ingress.host" -}}
  {{- $appName:=(include "app.name" .) }}
  {{- $env:=(include "app.env" .) }}
  {{- $host:="192.168.33.101.nip.io" }}
  {{- if .Values.ingress.enabled }}
    {{- if contains "prod" $env }}
      {{- printf "%s.%s" $appName $host -}}
    {{- else}}
      {{- printf "%s-%s.%s" $env $appName $host -}}
    {{- end }}
  {{- end }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "single.chart" -}}
    {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common env
*/}}
{{- define "common.env" -}}
- name: PROJECT_NAME
  value: {{ include "app.project" . }}
- name: ENVIRONMENT
  value: {{ include "app.env" . }}
- name: SERVICE_NAME
  value: {{ include "app.name" . }}
{{- end -}}


{{/*
Common labels
*/}}
{{- define "common.labels" -}}
projectname: {{ include "app.project" . }}
environment: {{ include "app.env" . }}
servicename: {{ include "app.name" . }}
{{- end -}}

{{/*
labels for helm
*/}}
{{- define "single.labels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ include "single.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
