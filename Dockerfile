FROM ruby:2.7.4
RUN apt-get update && apt-get install -y nodejs
WORKDIR /qashio_api_rails
COPY Gemfile /qashio_api_rails/Gemfile
COPY Gemfile.lock /qashio_api_rails/Gemfile.lock
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server","-p", "3000", "-b", "0.0.0.0"]