FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs curl
WORKDIR /app
COPY Gemfile* /app/
RUN gem install bundler --no-document && bundle install --jobs 4
COPY . /app
ENV RAILS_ENV=production
EXPOSE 3000
CMD ["bash", "-lc", "bundle exec rails db:migrate && bundle exec rails s -b 0.0.0.0 -p 3000"]
