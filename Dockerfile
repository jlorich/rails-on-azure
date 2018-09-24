FROM ruby:2.5.1-stretch

ENV TMPDIR /tmp

RUN apt-get update && apt-get install -y \
        git \
        build-essential \
        g++ \
        libpq-dev \
        qt4-dev-tools \
        libqt4-dev \
        nodejs

RUN mkdir -p /var/app

WORKDIR /var/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . ./

EXPOSE 3333

ENTRYPOINT bundle exec rails s -p 3333 -b 0.0.0.0