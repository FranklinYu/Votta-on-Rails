FROM ruby:2.4.0-alpine

ARG app_path=/usr/src/app/

RUN mkdir -p $app_path
WORKDIR $app_path

# required only in Alpine Linux
RUN [ "apk", "add", "--update-cache", "tzdata" ]

COPY gems.rb $app_path
COPY gems.locked $app_path
RUN apk add --update-cache build-base postgresql-dev && \
	bundle install --frozen --without development test doc && \

	# make sure runtime dependencies is not purged:
	apk add musl postgresql-libs && \

	# purge build time dependencies:
	apk del build-base postgresql-dev

COPY . $app_path

ENV RAILS_ENV=production
CMD [ "bin/entrypoint", "puma" ]
