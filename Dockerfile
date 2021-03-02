FROM ruby:2.7.2-slim

RUN apt-get update -qq && \
    apt-get install -y build-essential && \
    apt-get install -y libpq-dev libxml2-dev libxslt1-dev nodejs chromium-driver && \
    apt-get install -y git

ENV APP_HOME /app

ENV BUNDLE_PATH /gems

RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/

RUN gem install bundler

ADD . $APP_HOME
