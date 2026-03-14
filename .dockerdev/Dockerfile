# syntax=docker/dockerfile:1

ARG RUBY_VERSION
ARG DISTRO_NAME=bookworm

FROM ruby:$RUBY_VERSION-slim-$DISTRO_NAME

ARG DISTRO_NAME

# Common dependencies
# Using --mount to speed up build with caching, see https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#run---mount
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache; \
  apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git

ARG PG_MAJOR
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgres-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/postgres-archive-keyring.gpg] https://apt.postgresql.org/pub/repos/apt/" \
    $DISTRO_NAME-pgdg main $PG_MAJOR | tee /etc/apt/sources.list.d/postgres.list > /dev/null
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=tmpfs,target=/var/log \
  apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    libpq-dev \
    postgresql-client-$PG_MAJOR

# Application dependencies
# We use an external Aptfile for this, stay tuned
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=tmpfs,target=/var/log \
    --mount=type=bind,source=Aptfile,target=/tmp/Aptfile \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      $(grep -Ev '^\s*#' /tmp/Aptfile | xargs)

# Bun install
ENV BUN_INSTALL=/usr/local/bun
ENV PATH=/usr/local/bun/bin:$PATH
RUN curl -fsSL https://bun.sh/install | bash

# Install Claude CLI
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH /root/.local/bin:$PATH
ENV IS_SANDBOX 1

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Store Bundler settings in the project's root
ENV BUNDLE_APP_CONFIG=.bundle

# Uncomment this line if you want to run binstubs without prefixing with `bin/` or `bundle exec`
ENV PATH /app/bin:$PATH

# Upgrade RubyGems and install the latest Bundler version
RUN gem update --system && \
    gem install bundler

# Set environment variables
ENV LD_PRELOAD="libjemalloc.so.2" \
    MALLOC_CONF="background_thread:true,metadata_thp:auto,dirty_decay_ms:5000,muzzy_decay_ms:5000,narenas:2" \
    RUBY_YJIT_ENABLE="1"

# Create a directory for the app code
RUN mkdir -p /app
WORKDIR /app

# Document that we're going to expose port 3000
EXPOSE 3000
# Use Bash as the default command
CMD ["/bin/bash"]

