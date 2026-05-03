# 🚀 Continuous Delivery Infrastructure

[![Security Scan](https://img.shields.io/badge/security-scanned-success.svg)](#)
[![Docker](https://img.shields.io/badge/docker-powered-blue.svg)](#)
[![Maintenance](https://img.shields.io/badge/maintenance-active-green.svg)](#)

This repository serves as a centralized, modular, and containerized infrastructure for modern Continuous Delivery pipelines. It provides a suite of industry-standard tools for static code analysis, security scanning, and vulnerability management, all managed through a unified interface.

## 🏗 Architecture Overview

The project is designed with a "Tools-as-a-Service" philosophy. Each tool resides in its own directory within `tools/`, containing its `docker-compose.yml` and environment configuration.

```text
.
├── tools/
│   ├── sonarqube/        # Static Code Analysis (SAST) & Quality Gates
│   ├── gitleaks/         # Secret Scanning (API Keys, Passwords)
│   ├── trivy/            # Vulnerability Scanner (Containers, IaC, Dependencies)
│   ├── defectdojo/       # Vulnerability Management Dashboard
│   ├── dependency-check/ # OWASP Dependency Analysis (SCA)
│   └── hadolint/         # Dockerfile Linter
├── docs/
│   └── PROJECT_INTEGRATION_PROMPT.md # AI-Powered Integration Guide
├── Makefile              # Unified Management Interface
└── README.md
```

---

## 🛠 Management Interface

A central `Makefile` is provided to abstract the complexity of Docker Compose. You can manage any tool using the `TOOL` variable.

### Core Commands
| Action | Command | Description |
| :--- | :--- | :--- |
| **Start** | `make up TOOL=<name>` | Provisions and starts the tool (auto-creates `.env`) |
| **Stop** | `make down TOOL=<name>` | Stops and removes containers |
| **Restart** | `make restart TOOL=<name>` | Restarts the specified service |
| **Logs** | `make logs TOOL=<name>` | Streams live logs from the container |
| **Status** | `make status TOOL=<name>` | Checks the health and status of containers |
| **Shell** | `make shell TOOL=<name>` | Opens an interactive terminal inside the container |

---

## 🔍 Tooling Inventory

### 1. SonarQube (Static Analysis)
SonarQube provides continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells, and security vulnerabilities.
- **Access**: `http://localhost:9000`
- **Default Login**: `admin / admin` (Change on first login)
- **Setup**: Ensure your host has `vm.max_map_count=262144` set.

### 2. Gitleaks (Secret Detection)
A SAST tool for detecting hardcoded secrets like passwords, API keys, and tokens in git repositories.
- **Usage**: `make up TOOL=gitleaks`
- **Output**: Scan results appear in the container logs (`make logs TOOL=gitleaks`).

### 3. Trivy (Security Scanner)
A comprehensive security scanner for container images, file systems, and git repositories.
- **Scanners**: Vulnerabilities (CVEs), Misconfigurations (IaC), and Secrets.
- **Usage**: `make up TOOL=trivy`

### 4. DefectDojo (Vulnerability Management)
An open-source vulnerability management tool that streamlines the testing process by offering a hub for vulnerability findings.
- **Access**: `http://localhost:8080`
- **Setup**: Update `tools/defectdojo/.env` with secure credentials before the first run.
- **Integration**: Ideal for centralizing reports from all other tools in this repo.

### 5. OWASP Dependency-Check (SCA)
Identifies project dependencies and checks if there are any known, publicly disclosed vulnerabilities.
- **Usage**: `make up TOOL=dependency-check`
- **Note**: The initial run takes longer as it downloads the NVD (National Vulnerability Database).

### 6. Hadolint (Dockerfile Linter)
A smarter Dockerfile linter that helps you build best practice Docker images.
- **Usage**: `make up TOOL=hadolint`
- **Auto-Discovery**: Scans all `Dockerfile` files found in the project root recursively.

---

## 🤖 AI-Powered Integration

One of the most powerful features of this repository is the **Master Prompt**. It allows you to quickly integrate this entire infrastructure into any of your existing projects using AI.

👉 **[Read the Project Integration Guide (Portuguese)](docs/PROJECT_INTEGRATION_PROMPT.md)**

Using the prompt provided in that guide, you can ask an AI to:
1. Detect your project's technology stack.
2. Generate `ci-scan.sh` scripts that point to this infra.
3. Configure `sonar-project.properties` automatically.
4. Setup automated uploads to DefectDojo.

---

## 🛡 Security Best Practices

- **Environment Isolation**: All tools run in dedicated Docker networks.
- **Secret Management**: `.env` files are never committed. Use the provided `.env.example` as a template.
- **Persistence**: Data is persisted via Docker volumes, ensuring no loss of analysis history between restarts.
- **Least Privilege**: Scanners like Hadolint and Gitleaks mount the codebase as `read-only` (`:ro`).

---

## 🗺 Roadmap

- [x] Core Security Tooling (SonarQube, Gitleaks, Trivy)
- [x] Vulnerability Management (DefectDojo)
- [x] Docker Best Practices (Hadolint)
- [ ] Jenkins / GitLab CI Integration Examples
- [ ] Centralized Auth (Keycloak)
- [ ] Monitoring Dashboard (Grafana/Prometheus)

---

Developed by [Gustavo Hyppolito](https://github.com/ghyppolito)
