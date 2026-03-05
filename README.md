# Szkoleo - Modern eLearning webapp built with Ruby

![Preview](.github/images/preview.png)

## Setup

The easiest way to run the project locally is with Docker Compose — it spins up the Rails app, PostgreSQL, DragonflyDB (Redis-compatible cache), MinIO (S3-compatible storage), and Mailcatcher all at once.

**Prerequisites:** Docker & Docker Compose installed.

### 1. Clone the repository

```bash
git clone https://github.com/PatRogala/elearning.git
cd elearning
```

### 2. Start all services

```bash
docker compose up --build
```

This builds the dev image (Ruby 4, Bun, PostgreSQL client) and starts:

| Service | URL |
|---|---|
| Rails app | http://localhost:3000 |
| MinIO console | http://localhost:9001 |
| Mailcatcher web UI | http://localhost:1080 |

### 3. Set up the database

On the first run the entrypoint script (`bin/docker-entrypoint`) automatically runs `db:prepare`. If you need to reset or reseed manually:

```bash
docker compose exec backend bin/rails db:reset
```

### 4. Create the MinIO bucket

Active Storage is configured to use MinIO in development. Create the required bucket once the stack is up.

Open the MinIO console at http://localhost:9001 (credentials: `minio` / `miniodevelopment`) and create a bucket named `default-bucket` manually.

## BetterStack Integration

Production logs are shipped to [BetterStack](https://betterstack.com) via the `logtail-rails` gem. The logger is configured in `config/environments/production.rb` using Rails credentials.

Add the required credentials with:

```bash
bin/rails credentials:edit
```

Include the following keys:

```yaml
logtail:
  source_token: <your-betterstack-source-token>
  ingesting_host: <your-betterstack-ingesting-host>
```

Both values are available in your BetterStack source settings. Once set, all production logs are automatically forwarded to your BetterStack dashboard.

## Skylight Integration

Performance monitoring is handled by [Skylight](https://www.skylight.io) via the `skylight` gem. The authentication token is loaded from Rails credentials in `config/initializers/skylight.rb`.

Add the required credential with:

```bash
bin/rails credentials:edit
```

Include the following key:

```yaml
skylight:
  authentication: <your-skylight-authentication-token>
```

The token is available in your Skylight app settings. Once set, Skylight automatically profiles your Rails app and surfaces slow endpoints, N+1 queries, and other performance issues in your Skylight dashboard.
