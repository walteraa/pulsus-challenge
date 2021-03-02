echo 'Running bundle install...\n\n'
bundle install
sleep 5
bundle exec rails db:setup

bundle exec puma -C config/puma.rb