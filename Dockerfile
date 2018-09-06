FROM ruby:2.5.1-stretch

RUN apt-get update && apt-get install -y \
        git \
        build-essential \
        g++ \
        libpq-dev \
        qt4-dev-tools \
        libqt4-dev \
        nodejs

# RUN mkdir -p /var/app
# COPY Gemfile /var/app/Gemfile

WORKDIR /var/app

#RUN bundle clean --force
#RUN bundle install