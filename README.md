# Cloud Custodian Helm Chart

First, you need to get the repo added to helm!

```sh
helm repo add c7n https://cloud-custodian.github.io/helm-charts/
helm repo update
helm search repo c7n -l
```

From there you can setup a `values.yml` file and install it.  A good starting
point is this:

```yaml
certManager:
  enabled: true

policies:
  source: configMap
  configMap:
    policies:
      - name: missing-recommended-labels
        mode:
          type: k8s-admission
          on-match: deny
          operations:
            - CREATE
            - UPDATE
        description: |
          Kubernetes recommmended the following labels from its docs:
          app.kubernetes.io/name
          app.kubernetes.io/instance
          app.kubernetes.io/version
          app.kubernetes.io/component
          app.kubernetes.io/part-of
          app.kubernetes.io/managed-by
          https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
        resource: k8s.pod
        filters:
          - or:
              - metadata.labels."app.kubernetes.io/name": absent
              - metadata.labels."app.kubernetes.io/instance": absent
              - metadata.labels."app.kubernetes.io/version": absent
              - metadata.labels."app.kubernetes.io/component": absent
              - metadata.labels."app.kubernetes.io/part-of": absent
              - metadata.labels."app.kubernetes.io/managed-by": absent

webhook:
  caBundle: will-be-replaced-by-cert-manager

  rules:
    - apiGroups: [""]
      apiVersions: ["v1"]
      operations: ["CREATE"]
      resources: ["pods"]
      scope: Namespaced
```

This will provide you with your first policy that enforces best practice labeling
on your pods. Then you can install the chart!

```sh
helm install c7n-kube c7n/c7n-kube  --namespace c7n-system -f values.yml --create-namespace
```

**Full documentation at: https://cloudcustodian.io/**
