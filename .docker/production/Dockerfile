########################
###    app config    ###
########################

FROM ruby:2.6.3 AS app

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
ENV BUNDLER_VERSION=$BUNDLER_VERSION
RUN echo "\n\nbundler version: "$BUNDLER_VERSION
RUN apt-get update && \
    apt-get -yq dist-upgrade && \
    apt-get install -y tzdata build-essential vim && \
    apt-get autoremove -y && \
    gem update --system && \
    gem install bundler:$BUNDLER_VERSION 

COPY . $HOME

# Setting env up
ENV RAILS_ENV='production'
ENV NODE_ENV='production'

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install --jobs 20 --retry 5 --without development test 

COPY . .

RUN rm -f /cartafact/config/master.key && rm -f /cartafact/config/credentials.yml.enc


########################
### web/nginx config ###
######################## 

FROM nginx:1.17.6-alpine as web

RUN mkdir /cartafact

# copy assets from the app build and nginx config
#COPY --from=app /cartafact/public /cartafact/
COPY .docker/production/nginx.conf /etc/nginx/conf.d/cartafact.conf
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf-bkp
