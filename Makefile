AZ_ACR_NAME=mocscoil1

HELM_REGISTRY=$(AZ_ACR_NAME).azurecr.io
HELM_USER=00000000-0000-0000-0000-000000000000
HELM_PASS=$(shell az acr login --name mocscoil1 --expose-token --only-show-errors | jq .accessToken -r)
HELM_CHART=demo1
HELM_VERSION=1.2.0
HELM_APP_VERSION=v1.2

default: helm-push

helm-deps:
	helm dependency build apps/dev
	helm dependency build apps/test
	helm dependency build apps/prod

helm-login:
	helm registry login $(HELM_REGISTRY) --username=$(HELM_USER) --password=$(HELM_PASS)

helm-package:
	helm package charts/$(HELM_CHART) --version=$(HELM_VERSION) --app-version=$(HELM_APP_VERSION)

helm-push: helm-package
	helm push $(HELM_CHART)-$(HELM_VERSION).tgz oci://$(HELM_REGISTRY)/helm

clean:
	find apps -name charts -exec rm -rf {} \;
	find apps -name Chart.lock -exec rm -f {} \;
	rm -f *.tgz
