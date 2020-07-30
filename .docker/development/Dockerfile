FROM ruby:2.6.3 AS cartafact_base


ENV HOME /cartafact

RUN mkdir -p $HOME

WORKDIR $HOME

# Configure bundler and PATH
ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /cartafact/bin:$BUNDLE_BIN:$PATH

ARG BUNDLER_VERSION

RUN apt-get update && \
    apt-get -yq dist-upgrade && \
    apt-get install -y tzdata build-essential vim && \
    apt-get autoremove -y && \
    gem update --system && \
    gem install bundler:$BUNDLER_VERSION 

COPY . $HOME

# Setting env up
ENV RAILS_ENV='development'
ENV NODE_ENV='development'

RUN bundle config set deployment 'true' && \
    bundle install
