require 'bundler'
Bundler.require(:rake)

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp", "pkg/**/*.pp"]
  config.log_format = '%{path}:%{linenumber}:%{KIND}: %{message}'
  # TODO: remove this check once the relative config
  # is supported by puppet-lint release
  config.disable_checks = [ 'autoloader_layout' ]
end

# use librarian-puppet to manage fixtures instead of .fixtures.yml
# offers more possibilities like explicit version management, forge downloads,...
task :librarian_spec_prep do
#  sh "librarian-puppet install --path=spec/fixtures/modules/"
  pwd = `pwd`.strip
  # because we don't have librarian-puppet
  unless File.directory?("#{pwd}/spec/fixtures/modules")
    sh "mkdir -p #{pwd}/spec/fixtures/modules"
  end
  unless File.directory?("#{pwd}/spec/fixtures/modules/sysctl")
    sh "ln -s #{pwd} #{pwd}/spec/fixtures/modules/sysctl"
  end
end
task :spec_prep => :librarian_spec_prep


task :default => [:spec, :lint]
