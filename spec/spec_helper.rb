require 'rspec-puppet'
require 'rspec-puppet-facts'
include RspecPuppetFacts

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.environmentpath = File.join(Dir.pwd, 'spec')
end

SUPPORTED_OS = [
  { 'operatingsystem'        => 'CentOS',
    'operatingsystemrelease' => [ '6', '7' ] },
  { 'operatingsystem'        => 'Ubuntu',
    'operatingsystemrelease' => [ '14.04', '16.04', '18.04' ] },
  { 'operatingsystem'        => 'Debian',
    'operatingsystemrelease' => [ '8', '9' ] },
  { 'operatingsystem'        => 'OpenBSD',
    'operatingsystemrelease' => [ '6.2', '6.3' ] },
  { 'operatingsystem'        => 'FreeBSD',
    'operatingsystemrelease' => [ '10', '11' ] }
]
