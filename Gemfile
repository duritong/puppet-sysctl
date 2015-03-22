source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "~> #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.7.4']
end

gem 'puppet', puppetversion
# Support ruby 1.8.7
# https://github.com/rspec/rspec-core/issues/1864
gem 'rspec', '< 3.2.0'
gem 'puppet-lint'
gem 'puppetlabs_spec_helper'
gem 'rake'
#gem 'librarian-puppet'
