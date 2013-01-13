require 'bundler'
require 'rake/testtask'

Bundler.require

task :default => :test

Rake::TestTask.new do |test|
  test.test_files = FileList['test/test_*.rb']
end

task :console do
  sh "irb -rubygems -r ./lib/killswitch.rb"
end

