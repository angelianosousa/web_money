FROM ruby:2.7.5

# Environment variables
ENV RAILS_LOG_TO_STDOUT true

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    nodejs \
    npm

RUN gem install bundler -v 2.1.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

# Building JS
RUN npm install --global yarn
RUN yarn install --check-files

# Building Rails
RUN bundle check || bundle install

COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]