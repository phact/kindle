require 'bundler'
require 'rake/clean'
require 'rake/testtask'
require 'rspec'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
gem 'rdoc' # we need the installed RDoc gem, not the system one
require 'rdoc/task'

include Rake::DSL

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.pattern = 'test/*_test.rb'
end

desc "Run all specs"
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = FileList['spec/**/*.rb']
end

CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  t.fork = false
end

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
end

task :default => [:spec,:features]
