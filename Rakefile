require 'rubygems'
require 'appraisal'
require 'bundler/setup'
require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default do
  if ENV['BUNDLE_GEMFILE'] == File.expand_path('Gemfile')
    exec 'rake appraisal:all'
  else
    Rake::Task['spec'].invoke
  end
end
