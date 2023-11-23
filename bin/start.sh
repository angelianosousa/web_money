#!/bin/bash

set -e

rm -f /app/tmp/pids/server.pid

echo ""
echo "  oooo     oooo ooooooooooo oooooooooo       oooo     oooo  ooooooo  oooo   oooo oooooooooooooooo  oooo  "
echo "   88   88  88   888    88   888    888       8888o   888 o888   888o 8888o  88   888    88   888  88    "
echo "    88 888 88    888ooo8     888oooo88        88 888o8 88 888     888 88 888o88   888ooo8       888      "
echo "     888 888     888    oo   888    888       88  888  88 888o   o888 88   8888   888    oo     888      "
echo "      8   8     o888ooo8888 o888ooo888       o88o  8  o88o  88ooo88  o88o    88  o888ooo8888   o888o     "
echo ""

bundle check || bundle install
bundle exec rails db:setup db:migrate
bundle exec rake assets:precompile
bundle exec rails s -p 3000 -b 0.0.0.0

exec "$@"
