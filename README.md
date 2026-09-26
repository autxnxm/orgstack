
fs layout on the server:

/srv/orgs/{{ org_slug }}

/srv/orgs/acme/
├── config/
├── data/
├── backups/
└── releases/

/srv/orgs/acme/config/postgres.env
/srv/orgs/acme/config/authentik.env
/srv/orgs/acme/config/authentik/blueprints/

/srv/orgs/acme/data/postgres/
/srv/orgs/acme/data/redis/
/srv/orgs/acme/data/authentik/

/srv/orgs/acme/releases/
/srv/orgs/acme/backups/

/srv/orgs/{{ org_slug }}/config/authentik/blueprints


