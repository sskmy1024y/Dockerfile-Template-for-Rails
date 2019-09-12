FROM ruby:2.5

ENV LANG C.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH=/bundle \
    APP_DIR=/app/

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

COPY src/Gemfile $APP_DIR
COPY src/Gemfile.lock $APP_DIR

RUN gem install bundler && bundle install --clean

COPY src/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
