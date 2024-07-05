# Variables
DOCKER_BACKEND_IMAGE=optimus-backend
DOCKER_FRONTEND_IMAGE=optimus-frontend
VERSION=$(shell jq -r .version backend/package.json)
K8S_DIR=k8s

.PHONY: all build-backend build-frontend deploy-backend deploy-frontend deploy-ingress deploy-postgres

# Default target
all: build-backend build-frontend deploy-postgres deploy-backend deploy-frontend deploy-ingress

# Local development
run-local:
	docker compose build
	docker compose up

# Build Docker images
build-all: build-backend build-frontend

build-backend:
	cd backend && docker build -t $(DOCKER_BACKEND_IMAGE):$(VERSION) .

build-frontend:
	cd frontend && docker build -t $(DOCKER_FRONTEND_IMAGE):$(VERSION) .

# Deploy to Kubernetes
deploy-backend:
	kubectl apply -f $(K8S_DIR)/backend-deployment.yaml
	kubectl apply -f $(K8S_DIR)/backend-service.yaml

deploy-frontend:
	kubectl apply -f $(K8S_DIR)/frontend-deployment.yaml
	kubectl apply -f $(K8S_DIR)/frontend-service.yaml

deploy-ingress:
	kubectl apply -f $(K8S_DIR)/ingress.yaml

deploy-postgres:
	kubectl apply -f $(K8S_DIR)/postgres-deployment.yaml
	kubectl apply -f $(K8S_DIR)/postgres-service.yaml

# Clean up Kubernetes resources
clean:
	kubectl delete -f $(K8S_DIR)/backend-deployment.yaml || true
	kubectl delete -f $(K8S_DIR)/backend-service.yaml || true
	kubectl delete -f $(K8S_DIR)/frontend-deployment.yaml || true
	kubectl delete -f $(K8S_DIR)/frontend-service.yaml || true
	kubectl delete -f $(K8S_DIR)/ingress.yaml || true
	kubectl delete -f $(K8S_DIR)/postgres-deployment.yaml || true
	kubectl delete -f $(K8S_DIR)/postgres-service.yaml || true
