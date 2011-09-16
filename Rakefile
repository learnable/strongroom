#!/usr/bin/env rake

require "bundler/gem_tasks"
require "rake/testtask"

task default: :test

Rake::TestTask.new do |t|
  ENV["TESTOPTS"] = "-v"
  t.pattern = "spec/*_spec.rb"
end
