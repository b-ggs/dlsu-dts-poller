FROM ruby:2.6.1

ENV BUNDLE_PATH=/bundle
ENV BUNDLE_JOBS=2
ENV BUNDLE_BIN=/bundle/bin
ENV GEM_HOME=/bundle
ENV PATH="$BUNDLE_BIN:$PATH"

ENV BUNDLER_VERSION=2.0.1
RUN gem install bundler -v $BUNDLER_VERSION

ENV APP_DIR=/app
WORKDIR $APP_DIR

ADD Gemfile* ./
RUN bundle install --binstubs="$BUNDLE_BIN"

ADD . ./

ENTRYPOINT ["./entrypoint"]
