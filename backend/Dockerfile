FROM ruby:2.6.5
RUN gem install bundler:1.17.3
COPY Gemfile Gemfile.lock ./backend/
WORKDIR /backend
RUN bundle install
COPY . /backend
CMD ["rails", "server", "-b", "0.0.0.0"]
