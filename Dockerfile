FROM ruby:2.7.5

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    nodejs \
    npm

RUN mkdir /finantial_system

WORKDIR /finantial_system

COPY Gemfile /finantial_system/Gemfile
COPY Gemfile.lock /finantial_system/Gemfile.lock
COPY . /finantial_system

# Finish building
RUN gem install bundler -v 2.1.4
RUN bundle check || bundle install
RUN npm install --global yarn
RUN yarn install

EXPOSE 80

# Configure the main process to run when running the image
CMD ["rails", "server"]