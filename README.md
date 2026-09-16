# Launch Pad

A dead-simple, cheap ($4-7/month) self-hosted starter kit for side projects. Get a real app live on your own domain with HTTPS, a database, and zero DevOps yak-shaving.

No managed database bills, no per-service cloud pricing, no Kubernetes. Just Docker Compose on a single small VPS.

## What's included

- **Traefik** — reverse proxy that automatically gets you a free HTTPS certificate (Let's Encrypt) for your domain, no manual cert setup
- **Postgres** — your database, running in its own container, persisted to disk, never exposed to the public internet
- **app/** — a placeholder app you replace with your actual project (Node.js by default, swap the Dockerfile for whatever stack you want)

## Architecture

```
                  Internet
                     │
                     ▼ (ports 80/443 only)
              ┌──────────────┐
              │   Traefik    │  ← gets/renews your HTTPS cert automatically
              └──────┬───────┘
                     │
                     ▼
              ┌──────────────┐
              │   Your App   │  (the app/ folder — swap this for your project)
              └──────┬───────┘
                     │
                     ▼
              ┌──────────────┐
              │   Postgres   │  (internal network only — never public)
              └──────────────┘
```

## Getting a VPS

Any of these work — pick whichever you're comfortable with. All are roughly $4-7/month for a small instance:

- **Hetzner Cloud** — cheapest, great value
- **DigitalOcean** — simple, well-documented
- **AWS Lightsail** — if you're already in the AWS ecosystem, has a free-tier trial for the first few months

When creating the server, choose **Ubuntu** as the OS.

## Setup

1. Point your domain's DNS **A record** at your new server's IP address.
2. SSH into the server.
3. Clone this repo (or copy these files onto the server).
4. Run the bootstrap script: `sudo bash setup.sh` — installs Docker and Docker Compose.
5. Edit `.env` (copied from `.env.example`) with your real domain, email, and a strong Postgres password.
6. Start everything: `docker compose up -d`
7. Visit your domain — you should see the placeholder page over a valid HTTPS connection within a minute or two (Traefik needs a moment to issue the certificate).

## Replacing the placeholder app

Delete the contents of `app/` and drop in your real project, keeping a `Dockerfile` that exposes port `3000` (or update the port in `docker-compose.yml`'s Traefik label if your app uses a different one). Your app can reach Postgres via the `DATABASE_URL` environment variable, already wired up.

## Security notes

- Only open ports **80**, **443**, and **22** (SSH) on your server's firewall. Everything else should stay closed.
- Postgres has no `ports:` mapping in `docker-compose.yml` on purpose — it's only reachable from the `app` container, never from the internet.
- Change the default Postgres password in `.env` before going live. Don't commit `.env` to git — it's already in `.gitignore`.

## Cost

- VPS: ~$4-7/month (fixed price — no surprise bills, unlike raw cloud compute billing)
- Domain: ~$10-15/year
- HTTPS certificate: free (Let's Encrypt via Traefik)
