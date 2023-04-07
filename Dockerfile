FROM ruby:3.2.2

RUN mkdir -p /app
WORKDIR /app

RUN apt-get update -qq && apt-get install -y default-libmysqlclient-dev

RUN gem install bundler

COPY .ruby-version Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
