# Continuous Delivery Infrastructure

This repository contains the infrastructure and tooling necessary for a robust Continuous Delivery pipeline. Each tool is containerized using Docker Compose to ensure consistency across local development and production environments.

## Directory Structure

```text
.
├── tools/
│   └── sonarqube/       # Static Code Analysis
└── README.md
```

## Management with Makefile

To simplify management, a `Makefile` is provided at the root. You can control any tool using the `TOOL` variable.

### Commands
- **Start**: `make up TOOL=sonarqube`
- **Stop**: `make down TOOL=sonarqube`
- **Logs**: `make logs TOOL=sonarqube`
- **Status**: `make status TOOL=sonarqube`
- **Restart**: `make restart TOOL=sonarqube`

## Tools

### 1. SonarQube
...
#### Setup
1. **Host Config**: Ensure `vm.max_map_count=262144` is set.
2. **Start**:
   ```bash
   make up TOOL=sonarqube
   ```
3. **Configure**: Update the generated `tools/sonarqube/.env` if necessary.

### 2. Gitleaks
Gitleaks is a SAST tool for detecting and preventing hardcoded secrets like passwords, api keys, and tokens in git repos.

#### Usage
To scan the entire repository history:
```bash
make up TOOL=gitleaks
```
*Note: Since Gitleaks is a one-off scan, the container will exit once the scan is complete. You can view the results in the terminal output.*

#### View Results
```bash
make logs TOOL=gitleaks
```

### 3. Trivy
Trivy is a comprehensive security scanner for container images, file systems, and git repositories. It detects vulnerabilities (CVEs), misconfigurations, and secrets.

#### Usage
To scan the project for vulnerabilities and misconfigurations:
```bash
make up TOOL=trivy
```
*Note: Like Gitleaks, Trivy is a one-off scan. Use `make logs TOOL=trivy` if the output doesn't appear immediately.*

#### Scanners Enabled
- **vuln**: Software Composition Analysis (SCA) - scans dependencies.
- **config**: Infrastructure as Code (IaC) - scans Dockerfiles, etc.
- **secret**: Detects hardcoded secrets (complements Gitleaks).

### 4. DefectDojo
DefectDojo is an open-source vulnerability management tool that streamlines the testing process by offering a hub for vulnerability findings.

#### Setup
1. **Prepare Environment**:
   ```bash
   make up TOOL=defectdojo
   ```
2. **Configure**: Update `tools/defectdojo/.env` with a strong `DD_SECRET_KEY` and safe passwords.
3. **Wait**: The first startup involves database migrations and can take a couple of minutes.

#### Access
Access the dashboard at `http://localhost:8080`.
- **Default Login**: `admin` (or what you set in `.env`)
- **Default Password**: (defined in `.env`)

#### Integration
You can import reports from SonarQube, Gitleaks, and Trivy directly into DefectDojo to centralize your security posture.

### 5. Dependency-Check (OWASP)
OWASP Dependency-Check is a Software Composition Analysis (SCA) tool that attempts to detect publicly disclosed vulnerabilities contained within a project’s dependencies.

#### Usage
```bash
make up TOOL=dependency-check
```
*Note: The first run will download a large database of vulnerabilities (NVD). This can take several minutes.*

### 6. Hadolint
Hadolint is a smarter Dockerfile linter that helps you build best practice Docker images.

#### Usage
```bash
make up TOOL=hadolint
```
*Note: It will automatically find and scan all files named `Dockerfile` in the repository.*

#### Access
Access the dashboard at `http://localhost:9000` (or the port defined in `.env`).
- **Default Login**: `admin`
- **Default Password**: `admin`
*(You will be prompted to change the password on first login)*

## Security Best Practices
- **Never commit `.env` files**: Secrets are managed via environment variables and excluded from Git.
- **Dedicated Networks**: Containers communicate over isolated Docker networks.
- **Resource Limits**: Configured via `ulimits` and volumes for persistence.
- **Updates**: Use the `SONARQUBE_VERSION` variable in `.env` to manage upgrades safely.

## Future Roadmap
- [ ] Jenkins / GitLab Runner integration
- [ ] Docker Registry (Harbor)
- [ ] Monitoring (Prometheus/Grafana)
- [ ] Security Scanning (Trivy/Snyk)
