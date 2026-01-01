---
name: kamal-deploy
description: Deploy Docker applications using Kamal 2 with zero-downtime and automatic SSL. Use this skill when (1) setting up new Kamal deployments, (2) generating deploy.yml configuration, (3) deploying apps that lack health endpoints (using Caddy workaround).
---

# Kamal 2 Deployment

## Workflow

Ask user for:
1. **Domain** — e.g., `app.example.com` (service name: `app_example_com`)
2. **Server IP(s)**
3. **Health endpoint** — Does app return 200 on `/up` without auth?

## Generate config/deploy.yml

```yaml
service: {{DOMAIN_UNDERSCORED}}
image: jalen0x/{{DOMAIN_UNDERSCORED}}

servers:
  web:
    hosts:
      - {{SERVER_IP}}

proxy:
  ssl: true
  host: {{DOMAIN}}

registry:
  username: jalen0x
  password:
    - KAMAL_REGISTRY_PASSWORD

ssh:
  user: ubuntu

builder:
  arch: amd64
```

## Health Endpoint (Priority Order)

**1. Default `/up`**: App responds 200 on `/up` at port 80 → no extra config needed.

**2. Custom path**: App has different health endpoint → configure in proxy:
```yaml
proxy:
  healthcheck:
    path: /
    interval: 5
    timeout: 3
```

**3. No health endpoint (last resort)**: Use Caddy as reverse proxy.

Copy templates from `assets/` and customize:
- `assets/Caddyfile` → project `Caddyfile`
- `assets/start.sh` → project `start.sh`

Generate Dockerfile:
```dockerfile
FROM {{BASE_IMAGE}}
RUN apk add --no-cache caddy
COPY Caddyfile /Caddyfile
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/bin/sh", "/start.sh"]
```

## Commands

```bash
kamal setup   # First-time
kamal deploy  # Deploy
```
