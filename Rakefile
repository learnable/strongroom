require "rake/testtask"

task default: :test

Rake::TestTask.new do |t|
  ENV["TESTOPTS"] = "-v"
  t.pattern = "spec/*_spec.rb"
end
