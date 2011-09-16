# -*- encoding: utf-8 -*-
require File.expand_path('../lib/strongroom/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Annesley"]
  gem.email         = ["paul@annesley.cc"]
  gem.description   = %q{Strong public-key encryption for arbitrary length data.}
  gem.summary       = %q{Strongroom uses RSA and AES encryption from Ruby's OpenSSL bindings to encrypt arbitrary length data with a public key.}
  gem.homepage      = "https://github.com/learnable/strongroom"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "strongroom"
  gem.require_paths = ["lib"]
  gem.version       = Strongroom::VERSION

  gem.required_ruby_version = ">= 1.9.2"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "simplecov"
end
