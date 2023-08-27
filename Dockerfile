FROM ruby:2.7.5 AS builder

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV
ENV BUNDLE_PATH /home/webmoney/bundle

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential tzdata curl ruby-dev ca-certificates \
  libpq-dev \
  imagemagick libxslt-dev libxml2-dev \
  nodejs && gem install -N bundler

RUN adduser --disabled-password --gecos "" webmoney
USER webmoney
WORKDIR /home/webmoney/app

COPY --chown=webmoney Gemfile Gemfile.lock ./
RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --without development test; else bundle install; fi

COPY --chown=webmoney . .

FROM builder AS test

RUN chmod +x ./bin/specs.sh
EXPOSE 3000

FROM builder AS dev

RUN chmod +x ./bin/start.sh
EXPOSE 3000
ENTRYPOINT ["./bin/start.sh"]

# TODO can be improved later