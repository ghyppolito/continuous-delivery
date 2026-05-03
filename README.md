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
