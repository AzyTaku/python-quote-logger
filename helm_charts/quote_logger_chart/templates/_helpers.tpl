{{/*
Expand the name of the chart.
*/}}
{{- define "quote-logger-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "quote-logger-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" | replace "_" "-" | lower }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" | replace "_" "-" | lower }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" | replace "_" "-" | lower }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version.
*/}}
{{- define "quote-logger-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "quote-logger-chart.labels" -}}
helm.sh/chart: {{ include "quote-logger-chart.chart" . }}
{{ include "quote-logger-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "quote-logger-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quote-logger-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use.
*/}}
{{- define "quote-logger-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "quote-logger-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get Loki storage bucket names safely with defaults
*/}}
{{- define "loki.bucketNames" -}}
{{- $buckets := dict "chunks" "chunks" "index" "index" -}}
{{- if and .Values.loki .Values.loki.storage .Values.loki.storage.bucketNames }}
{{- $buckets = .Values.loki.storage.bucketNames }}
{{- end }}
{{- $buckets }}
{{- end }}

{{/*
Get Loki storage config safely
*/}}
{{- define "loki.storageConfig" -}}
{{- if .Values.loki.storage_config }}
{{- .Values.loki.storage_config }}
{{- else }}
boltdb_shipper:
  active_index_directory: /data/loki/index
  cache_location: /data/loki/cache
  shared_store: filesystem
{{- end }}
{{- end }}

{{/*
Get Loki common config safely
*/}}
{{- define "loki.commonConfig" -}}
{{- if .Values.loki.commonConfig }}
{{- .Values.loki.commonConfig }}
{{- else }}
auth_enabled: false
{{- end }}
{{- end }}
