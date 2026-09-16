#!/usr/bin/env bash
# Run this once on a fresh Ubuntu VPS (as root or with sudo) to install
# everything this stack needs, then bring the stack up.
set -euo pipefail

echo "Installing Docker..."
curl -fsSL https://get.docker.com | sh

echo "Installing the Docker Compose plugin..."
apt-get update -y
apt-get install -y docker-compose-plugin

echo "Enabling Docker to start on boot..."
systemctl enable docker

if [ ! -f .env ]; then
  echo "No .env found — copying .env.example. Edit it before starting!"
  cp .env.example .env
fi

echo ""
echo "Setup complete. Next steps:"
echo "  1. Edit .env with your real domain, email, and a strong Postgres password"
echo "  2. Point your domain's DNS A record at this server's IP"
echo "  3. Run: docker compose up -d"
