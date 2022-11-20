set -o errexit

bundle install
rails assets:precompile
rails assets:clean
rails db:migrate
rails db:seed
