IMAGE_NAME=helm-api
IMAGE_VERSION=1.0.1

KIND_NAMESPACE=app
HELM_RELEASE=myapp

# .PHONY: tells Make that these targets are not actual files
PHONY: setup-kind

build-image:
	@echo "Building Docker image..."
	@docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .

setup-kind:
	@echo "Starting kind cluster setup..."
	@kind create cluster --name kind
	@echo "Kind cluster 'kind' created successfully."
	@echo "Applying Kubernetes configurations..."
	kubectl create namespace $(KIND_NAMESPACE) 

kind-import:
	@echo "Importing Docker image into kind cluster..."
	@kind load docker-image $(IMAGE_NAME):$(IMAGE_VERSION) --name kind
	@echo "Docker image $(IMAGE_NAME):$(IMAGE_VERSION) imported into kind cluster."

kind-context:
	@echo "Setting kubectl context to kind cluster..."
	@kubectl config use-context kind-kind
	@echo "Current context set to: $(shell kubectl config current-context)"

clean:
	@echo "Cleaning up kind cluster..."
	@kind delete cluster --name kind

run-compose:
	@docker-compose down --remove-orphans
	@echo "Running docker-compose..."
	@docker-compose up --build

helm-check:
	@echo "Checking Helm chart..."
	@helm lint helm
	@echo "Helm chart is valid."

helm-upgrade:
	@echo "Installing Helm chart..."
	@helm upgrade --install $(HELM_RELEASE) helm/ \
		--set image.repository=$(IMAGE_NAME) \
		--set image.tag=$(IMAGE_VERSION) \
		--namespace $(KIND_NAMESPACE) \
		--create-namespace
	@echo "Helm release $(HELM_RELEASE) upgraded or installed successfully."

helm-uninstall:
	@echo "Uninstalling Helm release..."
	@helm uninstall $(HELM_RELEASE) --namespace $(KIND_NAMESPACE)
	@echo "Helm release $(HELM_RELEASE) uninstalled successfully."