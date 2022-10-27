# c7n-kube

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![AppVersion: 0.1.2](https://img.shields.io/badge/AppVersion-0.1.2-informational?style=flat-square)

Use c7n policies to warn/block kubernetes resource modifications.

# Configuration

There are two major decisions to be made: how to manage the webhook certificate, and where to put your policies.

## Webhook certificate

### cert-manager

If you have cert-manager installed in your cluster, you can configure the helm chart to take care of this for you.
The following values will create a self-signed issuer and a certificate, configure the pod to use it, and configure
the bundle on the webhook.

```
certManager:
  enabled: yes
  issuer:
    create: yes
  certificate:
    create: yes
```

### manual sync

If you don't have or want cert-manager, you can manage this yourself.

1. Generate a secret containing your certificate.
```
kubectl create secret tls your-secret-name \
  --namespace=your-namespace \
  --cert=tls.crt \
  --key=tls.key
```

2. Configure the resource
```
certmanager
  enabled: no
  certificate:
    create: no
    secretName: your-secret-name
```

## Policies

Two options for getting your policies into c7n-kube: use helm to create the ConfigMap, or manage the volume yourself.

### Use Helm to manage it

```
policies:
  source: configMap
  configMap:
    policies:
      - hello: world
```

### Create a volume yourself

```
policies:
  source: volume
  volume:
    configMap:
      name: a-config-map
  volumeMount:
    readOnly: true
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certManager.certificate.create | bool | `true` | Create a Certificate |
| certManager.certificate.name | string | `"{{ .Release.Name }}-webhook"` | The name of the Certificate |
| certManager.certificate.secretName | string | `"{{ .Release.Name }}-webhook"` | The name of the Certificate's secret |
| certManager.enabled | bool | `false` | Enable cert-manager support |
| certManager.issuer.create | bool | `true` | Create a self-signed certificate Issuer |
| certManager.issuer.name | string | `"{{ .Release.Name }}-issuer"` | The name of the created certificate Issuer |
| controller.annotations | object | `{}` | Annotations to apply to the controller |
| controller.create | bool | `true` | Create the controller that handles the webhook |
| controller.image | string | `"cloudcustodian/c7n:latest"` | The name of the image to use |
| controller.name | string | `"{{ .Release.Name }}"` | The name of the controller |
| controller.onException | string | `"warn"` | The action to take when the request results in an error |
| controller.port | int | `8443` | The port the deployment should listen on |
| controller.replicas | int | `1` | The controller's replica count |
| pod.annotations | object | `{}` | Annotations to apply to the pod |
| pod.labels | object | `{"app":"c7n_kube"}` | Labels applied to the pods |
| pod.name | string | `"{{ .Release.Name }}"` | The name of controller's pods |
| policies.configMap.name | string | `"{{ .Release.Name }}-policies"` | The name of the ConfigMap |
| policies.configMap.policies | list | `[]` | The policies to insert into the ConfigMap |
| policies.source | string | `""` | The source of policies. One of "configMap" or "volume" |
| policies.volume | object | `{}` | The policy volume |
| policies.volumeMount | object | `{}` | The policy volume mount |
| service.create | bool | `true` | True to create the service |
| service.name | string | `"{{ .Release.Name }}"` | The name of the service |
| service.port | int | `8443` | The service's port |
| webhook.caBundle | string | `""` | The static CA bundle. Necessary if not using cert-manager. |
| webhook.create | bool | `true` | True to create the webhook |
| webhook.failurePolicy | string | `"Ignore"` | How the webhook should react to an unexpected error: Ignore or Fail |
| webhook.matchPolicy | string | `""` | The webhook's match policy |
| webhook.namespaceSelector | object | `{}` | The webhook's namespace selector |
| webhook.objectSelector | object | `{}` | The webhook's object selector |
| webhook.rules | list | `[]` | The resources that the webhook should monitor |
