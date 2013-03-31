source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails',                '3.2.13'
gem 'secure_headers',       '0.3.0'
gem 'jquery-rails',         '2.2.1'
gem 'haml-rails',           '0.4'
gem 'thin',                 '1.5.0'
gem 'pg',                   '0.14.1'
gem 'rack-canonical-host',  '0.0.8'
# gem 'paperclip', '3.4.1'
# gem 'aws-sdk', '1.8.3.1'
# gem 'paranoia', '1.2.0'
# gem 'omniauth', '1.1.3'
# gem 'omniauth-facebook', '1.4.1'
# gem 'kaminari', '0.14.1'
# gem 'acts_as_hashed', '1.0.0'

group :assets do
  gem 'sass-rails',         '3.2.6'
  gem 'coffee-rails',       '3.2.2'
  gem 'uglifier',           '1.3.0'
end

group :development do
  gem 'foreman',            '0.61.0'
  gem 'integration', :git => 'git://github.com/mergulhao/integration.git'
end

group :test do
  gem 'webmock',            '1.9.3'
  gem 'shoulda-matchers',   '1.4.2'
  gem 'timecop',            '0.5.9.2'
  gem 'simplecov', '0.7.1', :require => false
  # gem 'guard-rspec', '2.4.1'
  gem 'capybara', '2.0.2'
  gem 'poltergeist',        '1.1.0'
end

group :development, :test do
  gem 'rspec-rails',        '2.13.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'pry-rails',          '0.2.2'
end
