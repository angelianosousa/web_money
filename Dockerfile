FROM ruby:2.7.5

RUN mkdir /finantial_system
WORKDIR /finantial_system

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    nodejs \
    npm

# Environment variables
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile /finantial_system/Gemfile
COPY Gemfile.lock /finantial_system/Gemfile.lock
COPY . /finantial_system
COPY package.json .
COPY yarn.lock .

# Finish building
RUN gem install bundler -v 2.1.4
RUN bundle check || bundle install
RUN npm install --global yarn
RUN yarn install

EXPOSE 8080

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0", "8080"]