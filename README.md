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

| Name                                   | Default | Description                                                                                                                                                                                                                        |
| -------------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lb.service.annotations`               | `{}`    | Set annotations for the loadbalancer service, e.g. to set cloud provider specific annotations for loadbalancer creation.
| `lb.service.loadBalancerIP`            | `""`    | Sets the IP address for codezero's loadbalancer service. If the IP address is the public IP for contacting the spaceagent set `spaceagent.externalHost` to the same value                                                          |
| `org.apikey`                           | `""`    | Your Organization API Key                                                                                                                                                                                                          |
| `org.id`                               | `""`    | Your Organization ID                                                                                                                                                                                                               |
| `opa.url`                              | `""`    | URL of your Open Policy Agent                                                                                                                                                                                                      |
| `opa.enabled`                          | `false` | If true enable OPA                                                                                                                                                                                                                 |
| `router.privilegedAccess`              | `false` | If true router pods are deployed with an empty securityContext                                                                                                                                                                     |
| `router.replicas`                      | `1`     | Number of replicas for router deployments on Serves                                                                                                                                                                                |
| `router.topologySpreadConstraints`     | `[]`    | Pod Topology Spread Constraints of router deployments                                                                                                                                                                              |
| `space.name`                           | `""`    | Name of Teamspace                                                                                                                                                                                                                  |
| `spaceagent.externalHost`              | `""`    | For cases where codezero's loadbalancer host is not public and custom networking/ingress is used to make the spaceagent publicly accessible                                                                                        |                                                                 |
| `spaceagent.replicas`                  | `1`     | Number of replicas for the Space Agent deployment`                                                                                                                                                                                 |
| `spaceagent.redis.secret`              | `""`    | Required when `spaceagent.replicas` is greater than 1. Name of the K8s Secret that contains the Redis connection parameters with the following `data` keys: `host`, `password`. The Secret must be in the Space Agent's namespace. |
| `spaceagent.topologySpreadConstraints` | `[]`    | Pod Topology Spread Constraints of Space Agent deployment                                                                                                                                                                          |
