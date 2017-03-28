# Votta on Rails

[![Dependency Status](https://gemnasium.com/badges/github.com/franklinyu/Votta-on-Rails.svg)](https://gemnasium.com/github.com/franklinyu/Votta-on-Rails)
[![Build Status](https://semaphoreci.com/api/v1/franklinyu/votta-on-rails/branches/master/badge.svg)](https://semaphoreci.com/franklinyu/votta-on-rails)
[![Security](https://hakiri.io/github/franklinyu/Votta-on-Rails/master.svg)](https://hakiri.io/github/franklinyu/Votta-on-Rails/master)
[![Code Climate](https://codeclimate.com/github/franklinyu/Votta-on-Rails/badges/gpa.svg)](https://codeclimate.com/github/franklinyu/Votta-on-Rails)
[![Test Coverage](https://codeclimate.com/github/franklinyu/Votta-on-Rails/badges/coverage.svg)](https://codeclimate.com/github/franklinyu/Votta-on-Rails/coverage)

## deploy on server

Prerequisite:

 * Ruby (version shown in the file `.ruby-version`)
 * [PostgreSQL][]

[PostgreSQL]: https://www.postgresql.org/download/

First, make sure that you have Bundler installed:

    $ gem install bundler

Then install the bundle with Bundler

    $ bundle install --deployment --without development test doc

Set up the environment variables `DATABASE_URL`, `RAILS_ENV`, and
`SECRET_KEY_BASE`. Typically `RAILS_ENV` should be `production`; `DATABASE_URL`
should be a [connection string][]; `SECRET_KEY_BASE` should be bytes (over 30
bytes, typically 128 bytes) in hexadecimal form. Now migrate the database:

    $ bundle exec rails db:migrate

Now you can launch Votta with Puma:

    $ bundle exec puma -C config/puma.rb

Note that the `-C` flag is aliased to `--config`. You can change the port
(default to 3000) with environment variable `PORT`.

[connection string]: https://www.postgresql.org/docs/9.6/static/libpq-connect.html#LIBPQ-CONNSTRING

### deploy with Docker

The easiest way to use [Docker][] is [Docker Compose][]. Docker 1.12.0 or above,
and Docker-Compose 1.6.0 or above, are required. Concerning the environment
variables, only `SECRET_KEY_BASE` is required when deploying with Docker; `PORT`
is respected if found. They can be specified as environment variables, like

    $ SECRET_KEY_BASE=deadbeef PORT=8080 docker-compose up

or specified in [environment file][]

    $ cat .env
    SECRET_KEY_BASE=deadbeef
    PORT=8080
    $ docker-compose up

[Docker]: https://www.docker.com/
[Docker Compose]: https://docs.docker.com/compose/
[environment file]: https://docs.docker.com/compose/env-file/

Instead of downloading (or cloning) the entire repository, one can also download
the `docker-compose.yaml` only, and replace the `build: .` with
`image: franklinyu/votta-web`, thanks to [Docker Hub]. The images are built by
continuous integration, so images there would at least pass all the tests.

[Docker Hub]: https://hub.docker.com/r/franklinyu/votta-web/

## test

Prerequisite:

 * Ruby (version shown in the file `.ruby-version`)

First, make sure that you have Bundler installed:

    $ gem install bundler

Then install the bundle with Bundler:

    $ bundle install --without development production doc

You need to re-run with the `--deployment` flag if this fails (which means you
are testing on an online container). Now test with RSpec:

    $ bundle exec rspec
