require "bundler/gem_tasks"

require 'rake/testtask'
require 'yard'
require 'flog'
require 'flog_task'
require 'flay'
require 'flay_task'
require 'reek/rake/task'

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/*_spec.rb']
  t.verbose = true
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']   # optional
  t.options = ['--any', '--extra', '--opts'] # optional
end

FlogTask.new :flog, 450, %w(lib)
FlayTask.new :flay, 10, %w(lib spec)

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
end

desc "Runs all code quality metrics"
task :quality => [:reek, :flog, :flay]
