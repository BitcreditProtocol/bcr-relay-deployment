# bcr-relay-deployment

Docker build and GCE deployment for the BCR relay

## Build with docker

```bash
docker build -t bcr-relay .
```

## For testing build and run with docker compose

A side note for running compose. When testing this it seems that the relay
starts faster than Postgres allows incoming connections which will shut down
the relay instantly (despite the depends on declaration). This can be fixed by
starting Postgres first with `-d` flag and then starting the relay with
`docker compose up`.

```bash
# just run it
docker compose up

# build or rebuild it
docker compose build --no-cache
```

## Deployment

For deployment, use the `Build and deploy bcr Nostr relay` GitHub action, which will deploy the current `release` branch of the [bcr-relay](https://github.com/BitcreditProtocol/bcr-relay).

