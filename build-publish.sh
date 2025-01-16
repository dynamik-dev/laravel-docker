#! /bin/bash

docker login ghcr.io -u dynamik-dev --password-stdin <<< "$GITHUB_TOKEN"
docker compose -f docker-compose.build.yml build
docker compose -f docker-compose.build.yml push