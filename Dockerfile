FROM ruby:3.0.6 AS builder

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV
ENV BUNDLE_PATH /home/webmoney/bundle

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential tzdata curl ruby-dev ca-certificates \
  libpq-dev \
  imagemagick libxslt-dev libxml2-dev npm \
  nodejs && gem install -N bundler && gem install rubocop

RUN adduser --disabled-password --gecos "" webmoney
USER webmoney
WORKDIR /home/webmoney/web

COPY --chown=webmoney Gemfile Gemfile.lock ./
COPY --chown=webmoney package.json ./
RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --without development test; else bundle install; fi
RUN npm install && bundle exec rails assets:precompile

COPY --chown=webmoney . .

FROM builder AS test

RUN chmod +x ./bin/specs.sh
EXPOSE 3000

FROM builder AS dev

RUN chmod +x ./bin/start.sh
EXPOSE 3000
ENTRYPOINT ["./bin/start.sh"]

# TODO can be improved later
