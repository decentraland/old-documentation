
FROM ruby:2.5-alpine

# install some useful packages
RUN apk --no-cache add \
  zlib-dev \
  build-base \
  libxml2-dev \
  libxslt-dev \
  readline-dev \
  libffi-dev \
  yaml-dev \
  zlib-dev \
  libffi-dev \
  cmake \
  nodejs

# set the default working directory
RUN mkdir -p /app
WORKDIR /app

# copy local files
COPY . /app

# build and export the app
RUN bundle install
RUN JEKYLL_ENV=production bundle exec jekyll build --destination /public