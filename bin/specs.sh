#!/bin/bash
set -e

bundle check || bundle install
bundle exec rails db:create db:migrate

echo "    ______     ______     ______   ______     ______       "
echo "   /\  == \   /\  ___\   /\  == \ /\  ___\   /\  ___\      "
echo "   \ \  __<   \ \___  \  \ \  _-/ \ \  __\   \ \ \____     "
echo "    \ \_\ \_\  \/\_____\  \ \_\    \ \_____\  \ \_____\    "
echo "     \/_/ /_/   \/_____/   \/_/     \/_____/   \/_____/    "

if [ -f "$1" ] || [ -d "$1" ]; then
  echo -e "\n RUNNING SUIT $1 \n"
  bundle exec rspec $1
else
  echo -e "\n RUNNING ALL SUITS \n"
  bundle exec rspec
fi
