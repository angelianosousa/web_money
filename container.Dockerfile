FROM ruby:2.7.5

ENV RAILS_ENV = 'development'
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential tzdata curl ruby-dev ca-certificates docker.io\
  libpq-dev imagemagick libxslt-dev libxml2-dev npm \
  nodejs && gem install -N bundler && gem install rubocop

EXPOSE 3000
