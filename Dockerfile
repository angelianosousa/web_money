# Ruby version
FROM ruby:2.7.5

# Building depedencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    postgresql-client \
    nodejs \
    npm \
    yarn

RUN mkdir /finantial_system

WORKDIR /finantial_system

# Finish building
RUN gem install bundler
RUN bundle check || bundle install
RUN npm install --global yarn
RUN yarn install

COPY Gemfile /finantial_system/Gemfile

COPY Gemfile.lock /finantial_system/Gemfile.lock

COPY . /finantial_system

EXPOSE 80

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]