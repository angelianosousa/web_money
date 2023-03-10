#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

rails db:create db:migrate
rails assets:precompile
rails s -b 0.0.0.0