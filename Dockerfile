FROM ruby:2.7.5
RUN apt-get update -qq && apt-get install -y postgresql-client

# for a JS runtime
RUN apt-get install -y nodejs npm
# RUN apt-get update

RUN mkdir /finantial_system

WORKDIR /finantial_system

COPY Gemfile /finantial_system/Gemfile
COPY Gemfile.lock /finantial_system/Gemfile.lock
RUN gem install bundler
RUN bundle check || bundle install
RUN npm install --global yarn
RUN yarn install
COPY . /finantial_system

EXPOSE 8080

# Configure the main process to run when running the image
CMD ["rails", "server"]