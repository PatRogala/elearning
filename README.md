# Szkoleo - Modern eLearning webapp built with Ruby

![Preview](.github/images/preview.png)

## Setup

The project uses [Ruby on Whales](https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development) — a Docker-based development environment managed by [`dip`](https://github.com/bibendi/dip). It spins up the Rails app, PostgreSQL, MinIO (S3-compatible storage), and Mailcatcher all at once.

**Prerequisites:**
- [Docker](https://docs.docker.com/engine/installation/) installed
- [`dip`](https://github.com/bibendi/dip) installed: `gem install dip`

### 1. Clone the repository

```bash
git clone https://github.com/PatRogala/elearning.git
cd elearning
```

### 2. Provision the environment

Builds the Docker image, installs gems and JS packages, and prepares the database:

```bash
dip provision
```

To start fresh (wipes all volumes):

```bash
RESET_DOCKER=true dip provision
```

### 3. Start the server

```bash
dip rails s
```

The app is available at http://localhost:3000.

### 4. Create the MinIO bucket

Active Storage is configured to use MinIO in development. On first run, open the MinIO console at http://localhost:9001 (credentials: `minio` / `miniodevelopment`) and create a bucket named `default-bucket`.

## Useful commands

```bash
# Open a Rails console
dip rails c

# Run database migrations
dip rails db:migrate

# Run tests
dip rails test

# Run CI
dip rails ci

# Install gems
dip bundle install

# Install JS packages
dip bun install

# Open a psql console
dip psql

# Open a Bash shell inside the container (with dependencies up)
dip runner

# Shut down all containers
dip down
```

For Claude CLI access inside the container:

```bash
dip claude
```

Authenticate on first launch. Sessions and settings persist in a Docker volume between runs.

See [`.dockerdev/README.md`](.dockerdev/README.md) for more details on the Docker setup.

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

## BetterStack Error Tracking

Errors are captured and shipped to [BetterStack](https://betterstack.com) via the Sentry SDK (`sentry-ruby`, `sentry-rails`). The initializer lives in `config/initializers/sentry.rb`.

**What gets tracked:**
- Unhandled exceptions in Rails controllers and middleware
- ActiveSupport and HTTP breadcrumbs for request context

Tracking is **only active in `production`**.

## Skylight Integration

Performance monitoring is handled by [Skylight](https://www.skylight.io) via the `skylight` gem. The authentication token is injected as an environment variable by Kamal at deploy time.

Set the token on the machine running `kamal deploy` (or in your CI secrets):

```bash
export SZKOLEO_SKYLIGHT_AUTHENTICATION=<your-skylight-authentication-token>
```

Kamal reads this via `.kamal/secrets` and injects `SKYLIGHT_AUTHENTICATION` into the production container. The token is available in your Skylight app settings.

## Resend Integration

Transactional emails in production are sent via [Resend](https://resend.com) using the `resend` gem. Action Mailer is configured to use Resend as the delivery method in `config/environments/production.rb`.

The API key is loaded from Rails credentials in `config/initializers/mailer.rb`.

Add the required credential with:

```bash
bin/rails credentials:edit
```

Include the following key:

```yaml
resend:
  api_key: <your-resend-api-key>
```

The API key is available in your Resend dashboard under **API Keys**.
