# kubernetes-helm-template

A reference project for deploying a Flask application using Docker, Kubernetes, and Helm. This repository demonstrates best practices for containerization, local Kubernetes development with Kind, and Helm-based configuration and deployment.

---

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Build and Run Locally](#build-and-run-locally)
  - [Using Docker Compose](#using-docker-compose)
  - [Kubernetes with Kind](#kubernetes-with-kind)
  - [Helm Chart Usage](#helm-chart-usage)
- [Configuration](#configuration)
- [Makefile Commands](#makefile-commands)
- [Helm Chart Details](#helm-chart-details)
- [Development Notes](#development-notes)
- [License](#license)

---

## Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
├── Makefile
├── base/
├── chart/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── config.yaml
│       ├── _helpers.yaml
│       └── NOTES.txt
|
├── overlays/
│   ├── dev/
│   └── prod/
|
├── src/
│   ├── app.py
│   └── settings.py
└── README.md
```

---

## Prerequisites

- [Docker](https://www.docker.com/)
- [Kind](https://kind.sigs.k8s.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/)

---

## Getting Started

### Using Docker Compose

1. **Build and run with Docker Compose:**
   ```sh
   docker-compose up --build
   ```

2. **Access the app at** [http://localhost:5000/](http://localhost:5000/)

---

### Kubernetes with Kind

1. **Create a Kind cluster:**
   ```sh
   make setup-kind
   ```

2. **Build and load the Docker image into Kind:**
   ```sh
   make build-image
   make kind-import
   ```

3. **Set kubectl context:**
   ```sh
   make kind-context
   ```

---

### Helm Chart Usage

1. **Lint the Helm chart:**
   ```sh
   helm lint helm
   ```

2. **Install the chart:**
   ```sh
   helm install myapp helm
   ```

3. **Upgrade the chart:**
   ```sh
   helm upgrade myapp helm
   ```

4. **Render templates without installing:**
   ```sh
   helm template myapp helm
   ```

5. **Port forward to access the app:**
   ```sh
   kubectl port-forward service/myapp-api-service 5000:5000
   ```

---

## Configuration

- **Image and version:** Set in `values.yaml` and `Makefile`.
- **Resources:** CPU and memory requests/limits are configurable in `chart/values.yaml`.
- **Environment variables:** Managed via Kubernetes ConfigMap (`config.yaml`).
- **Probes:** Liveness and readiness probes are set in `values.yaml` and injected into the deployment.

---

## Makefile Commands

- `make build-image` – Build the Docker image.
- `make setup-kind` – Create a Kind cluster and namespace.
- `make kind-import` – Load the Docker image into Kind.
- `make kind-context` – Set kubectl context to Kind.
- `make clean` – Delete the Kind cluster.

---

## Helm Chart Details

- **Deployment:** Deploys the Flask app with configurable replicas, resources, and probes.
- **Service:** Exposes the app as a ClusterIP service.
- **ConfigMap:** Injects environment variables into the app.
- **Helpers:** `_helpers.yaml` provides naming conventions for resources.

---

## Development Notes

- The Flask app exposes `/`, `/healthcheck`, and `/version` endpoints.
- The project is structured for easy extension to other Python web frameworks or microservices.
- Use the Helm chart for production-like deployments and configuration management.

---

## License

MIT License. See [LICENSE](LICENSE) for details.

