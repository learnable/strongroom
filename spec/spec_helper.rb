require "pathname"
$LOAD_PATH.unshift Pathname(__FILE__).dirname.parent.join("lib").to_path

require "minitest/autorun"

require "strongroom"
