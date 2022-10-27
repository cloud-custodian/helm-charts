# helm-charts
List the charts available like this:

```
helm repo add c7n https://cloud-custodian.github.io/helm-charts/
helm repo update
helm search repo c7n -l
```

# Local testing
To install the helm charts locally to verify its working you can run something
similar to:

```
helm install c7n-kube ./charts/c7n-kube --namespace c7n-system --values ./values.yml --create-namespace
```
