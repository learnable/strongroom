require "simplecov"
SimpleCov.start if ENV["SIMPLECOV"]

require "pathname"
$LOAD_PATH.unshift Pathname(__FILE__).dirname.parent.join("lib").to_path

require "minitest/autorun"

require "strongroom"

def fixture_path file
  Pathname.new(__FILE__).dirname.join("fixtures").join(file).to_path
end
