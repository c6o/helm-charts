# Helm charts for Codezero Space Agent

## Installing the Chart

```sh
helm repo add --force-update codezero https://charts.codezero.io
helm install --create-namespace --namespace=codezero \
  --set space.name='<TEAMSPACE NAME>' \
  --set org.id='<ORG_ID>' \
  --set org.apikey='<ORG_API_KEY>' \
  codezero codezero/codezero
```

## Upgrading the Chart

```sh
helm repo add --force-update codezero https://charts.codezero.io
helm upgrade --namespace=codezero codezero codezero/codezero
```

## Uninstalling the Chart

```sh
helm -n codezero uninstall codezero
kubectl delete ns codezero
```

## Configuration Options

| Name                      | Default | Description                                                    |
| ------------------------- | ------- | -------------------------------------------------------------- |
| `space.name`              | `""`    | Name of Teamspace                                              |
| `org.apikey`              | `""`    | Your Organization API Key                                      |
| `org.id`                  | `""`    | Your Organization ID                                           |
| `opa.url`                 | `""`    | URL of your Open Policy Agent                                  |
| `opa.enabled`             | `false` | If true enable OPA                                             |
| `router.privilegedAccess` | `false` | If true router pods are deployed with an empty securityContext |
