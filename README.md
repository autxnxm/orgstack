# OrgStack

Opinionated platform automation to deploy an essential self-hosted webapp stack for small organizations.

Built around a **1 org – 1 host** boundary using Debian 12+ and systemd Podman Quadlets, driven by a declarative manifest per organization.

---

## Quick Start

Execution is driven via the `Makefile` using an org manifest and secrets:

```bash
# 1. Bootstrap host (Debian base packages, Podman, systemd >= 252)
make bootstrap

# 2. Deploy core platform (core network, PostgreSQL, Redis, Authentik, Nginx)
make platform

# 3. Deploy enabled web applications
make apps

# 4. Verify systemd unit statuses and HTTP health endpoints
make verify
```

To run against a custom organization or environment:
```bash
make platform MANIFEST=manifests/myorg.yml SECRETS=secrets/myorg.yml INVENTORY=inventory/prod.ini
```

---

## Filesystem Layout

State and configuration are isolated under `/srv/orgs/{{ org_slug }}`:

```text
/srv/orgs/{{ org_slug }}/
├── config/                  # Configuration & credentials
│   ├── postgres.env
│   ├── authentik.env
│   ├── authentik/blueprints/
│   └── nginx/               # Bound 1:1 into Nginx at /etc/nginx (ro)
│       ├── nginx.conf
│       ├── mime.types
│       ├── certs/           # TLS cert & key
│       ├── includes/        # Shared snippets (proxy, ssl, authentik)
│       ├── sites-available/
│       └── sites-enabled/
├── data/                    # Persistent runtime volumes
│   ├── postgres/
│   ├── redis/
│   ├── authentik/
│   └── nginx/
│       ├── acme-challenge/  # Let's Encrypt webroot
│       └── html/            # Default landing & healthz
├── backups/                 # Database dumps & volume snapshots
└── releases/                # App release artifacts
```

---

## Ingress & App Routing

- **Single Gateway**: Nginx is the only container binding host ports `80` and `443`. All backend containers communicate privately across the internal `{{ org_slug }}-core` Podman network.
- **Zero-Friction TLS**: Automatically generates a fallback self-signed wildcard certificate on initial run so HTTPS works immediately in labs, with an ACME webroot challenge pre-routed for Let's Encrypt.
- **App Registration**: Apps drop a vhost file into `config/nginx/sites-available/<app>.conf` and toggle it via a relative symlink in `sites-enabled/`:
  ```bash
  ln -s ../sites-available/<app>.conf /srv/orgs/{{ org_slug }}/config/nginx/sites-enabled/<app>.conf
  ```
- **SSO Outpost**: Protect any application route with Authentik forward authentication by adding:
  ```nginx
  include /etc/nginx/includes/authentik-forward-auth.conf;
  ```
