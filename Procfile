web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: QUEUES=notifications bundle exec rake jobs:work
