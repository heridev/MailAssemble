source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.5'
gem 'pg', '~> 0.18.3'
gem 'sass-rails', '~> 5.0', '>= 5.0.5'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.1'
gem 'jquery-rails', '~> 4.1.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise', '~> 3.5.3'
gem 'haml', '~>4.0.7'
gem 'multi_json', '~> 1.2'
gem 'active_model_serializers', '~> 0.9.3'
gem 'rack-cors', require: 'rack/cors'
gem 'kaminari', '~> 0.17.0'
gem 'paper_trail', '~> 4.0.0'
gem 'delayed_job_active_record', '~> 4.1.0'
gem 'delayed_job_web', '~> 1.2.10'
gem 'mandrill_mailer', '~> 1.2.0'
gem 'aasm', '~> 4.3.0'
gem 'liquid', '~> 2.6.1'
gem 'unicorn', '~> 5.0.0'

gem 'bundler'
gem 'angular-rails-templates', '~> 0.2.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-ui-router'
  gem 'rails-assets-restangular'
  gem 'rails-assets-underscore'
  gem 'rails-assets-angular-growl-2'
  gem 'rails-assets-ngInfiniteScroll'
  gem 'rails-assets-angular-xeditable', '= 0.1.8'
  gem 'rails-assets-ngDialog'
  gem 'rails-assets-angular-ui-sortable', '= 0.13.4'
  gem 'rails-assets-jquery-ui'
end

group :production do
  gem 'rails_12factor', '~> 0.0.2'
end

# I tried to put this in assets group
# but it does not work for that reason
# this libraries are here :(
gem 'less-rails', '~> 2.7.1'
gem 'railsstrap', '~> 3.3.4'

group :development, :test do
  gem 'pry'
  gem 'spring'
end

