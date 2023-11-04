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
WORKDIR /home/webmoney/web
RUN mkdir -p /node_modules && chown -R webmoney:webmoney ./
USER webmoney

COPY --chown=webmoney Gemfile Gemfile.lock ./
COPY --chown=webmoney package.json package-lock.json ./
RUN npm install

COPY --chown=webmoney . .
RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --without development test; else bundle install; fi
RUN bundle exec rails assets:precompile

FROM builder AS test

RUN chmod +x ./bin/specs.sh
EXPOSE 3000

FROM builder AS dev

RUN chmod +x ./bin/start.sh
EXPOSE 3000
ENTRYPOINT ["./bin/start.sh"]

# TODO can be improved later
