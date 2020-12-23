# cloud-custodian-cron

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.9.9](https://img.shields.io/badge/AppVersion-0.9.9-informational?style=flat-square)

Cloud Custodian helm chart allowing use of cron jobs to schedule policy runs

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Optional affinity rules |
| nodeSelector | object | `{}` | Optional node selector rules |
| tolerations | list | `[]` | Optional tolerations to apply to the pod |
| podAnnotations | object | `{}` | Optional pod annotations |
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| serviceAccount.create | bool | `true` | Determines whether a service account is created |
| serviceAccount.name | string | `""` | The service account name to use |
| podSecurityContext | object | `{}` | Optional pod security context |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"cloudcustodian/c7n"` |  |
| imagePullSecrets | list | `[]` |  |
| envVars | object | `{}` | Extra environment variables to pass to cloud custodian  |
| resources | object | `{}` | Optional resources requests/limits |
| scheduledPolicies[].concurrencyPolicy | object | `{}` |  The cron job's concurrency policy |
| scheduledPolicies[].failedJobsHistoryLimit | int | `10` | Limit of how many failed jobs history to keep  |
| scheduledPolicies[].name | `nil` | none |  |
| scheduledPolicies[].policies | string | `nil` | The list of cloud custodian policies to run in the cron job |
| scheduledPolicies[].schedule | string | `nil` | The cron schedule at which interval the policies will be run |
| scheduledPolicies[].successfulJobsHistoryLimit | int | `10` | Limit of how many failed jobs history to keep |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` | Optional service account annotations |
