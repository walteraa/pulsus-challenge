bundle check || bundle install

bundle exec sidekiq -C config/sidekiq.yml