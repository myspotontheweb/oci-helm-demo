# Helm OCI demo

Illustrates how helm charts stored in an OCI registry like Azure ACR can be used for deployment. 

# Usage

Create a bootstrap application to install the platform services. Note the path setting will install services for the dev cluster

```
argocd app create dev-bootstrap \
   --repo https://github.com/myspotontheweb/oci-helm-demo.git \
   --path environments/dev \
   --dest-server https://kubernetes.default.svc \
   --dest-namespace argocd

argocd app set dev-bootstrap --sync-policy automated --self-heal
```

# Configuration


The following illustrates a GitOps scenario where a chart is being used for Dev, Test and Prod, pulling in a base chart as a dependency.

```
apps
└── demo1
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

# How to publish chart versions

Login to the ACR registry

```
make helm-login
```

Push a chart version

```
make HELM_VERSION=1.3.0 HELM_APP_VERSION=v1.3
```
