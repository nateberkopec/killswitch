require 'bundler'
require 'rake/testtask'

Bundler.require

task :default => :test

Rake::TestTask.new do |test|
  if ::RUBY_VERSION < '1.9'
    test.test_files = %w(test/test_killswitch.rb)
  else
    test.test_files = FileList['test/test_*.rb']
  end
end

task :console do
  sh "irb -rubygems -r ./lib/killswitch.rb"
end

