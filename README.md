# Optimus

This repository contains a simple web application with a front-end and back-end
service that does business-y things.

## Project Structure

```shell
optimus/
├── backend/
│   ├── Dockerfile
│   ├── app.js
│   ├── package.json
├── frontend/
│   ├── Dockerfile
│   ├── index.html
├── k8s/
│   ├── backend-deployment.yaml
│   ├── backend-service.yaml
│   ├── frontend-deployment.yaml
│   ├── frontend-service.yaml
│   ├── ingress.yaml
│   ├── postgres-deployment.yaml
│   ├── postgres-service.yaml
├── docker-compose.yml
├── Makefile
├── README.md
```

## Prerequisites

- Docker
- Kubernetes (e.g., Minikube or Docker Desktop with Kubernetes enabled)
- kubectl

## Setup and Deployment

### Local Development with Docker Compose

1. **Ensure Docker is running**.

2. **Create and start containers**:
   Navigate to the project directory and run:

   ```sh
   docker-compose up --build
   ```

3. **Access the Application**:
   - Frontend: [http://localhost](http://localhost)
   - Backend: [http://localhost:3000](http://localhost:3000)

### Kubernetes Deployment

1. **Build Docker Images**

   Navigate to the project directory and run:

   ```sh
   make build-backend
   make build-frontend
   ```

2. **Deploy to Kubernetes**

   Deploy the PostgreSQL database:

   ```sh
   make deploy-postgres
   ```

   Deploy the backend and frontend services:

   ```sh
   make deploy-backend
   make deploy-frontend
   ```

   Deploy the Ingress:

   ```sh
   make deploy-ingress
   ```

3. **Access the Application**

   Ensure your Kubernetes cluster is configured to use an Ingress controller
   and update your `/etc/hosts` file to include:

   ```sh
   <your-minikube-ip> optimus.local
   ```

   You can find the Minikube IP using:

   ```sh
   minikube ip
   ```

   Then, access the application at [http://optimus.local](http://myapp.local).

### Cleaning Up

To clean up the Kubernetes resources, run:

```sh
make clean
```

## License

This project is licensed under the MIT License.
