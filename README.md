# Helm OCI demo

Illustrates how helm charts stored in an OCI registry like Azure ACR can be used for deployment. 

The following illustrates a GitOps scenario where a chart is being used for Dev, Test and Prod, pulling in a base chart as a dependency.

```
apps
├── dev
│   ├── Chart.yaml
│   └── values.yaml
├── prod
│   ├── Chart.yaml
│   └── values.yaml
└── test
    ├── Chart.yaml
    └── values.yaml
```

## How to publish chart versions

Login to the ACR registry

```
make helm-login
```

Push a chart version

```
HELM_VERSION=1.3.0 HELM_APP_VERSION=v1.3 make 
```
