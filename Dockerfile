FROM ruby:3.3.3 AS base

WORKDIR /app

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    postgresql-client \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

FROM base AS development

ENV RAILS_ENV=development

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.19 && bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["bash", "bin/docker-entrypoint"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]

FROM base AS production

ENV RAILS_ENV=production \
    BUNDLE_WITHOUT="development:test" \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.19 && bundle install

COPY . .

RUN SECRET_KEY_BASE=dummy bundle exec rails assets:precompile

EXPOSE 3000

ENTRYPOINT ["bash", "bin/docker-entrypoint"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
