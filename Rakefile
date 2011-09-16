#!/usr/bin/env rake

task default: :test

# Bundler
require "bundler/gem_tasks"

# MiniTest
require "rake/testtask"
Rake::TestTask.new do |t|
  ENV["TESTOPTS"] = "-v"
  t.pattern = "spec/*_spec.rb"
end

desc "Generate SDoc documentation"
task :sdoc do
  # SDoc support for top-level classnames:
  # https://github.com/voloko/sdoc/pull/26
  sh "sdoc lib --main ::Strongroom"
end
