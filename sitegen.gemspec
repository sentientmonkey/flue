# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sitegen/version'

Gem::Specification.new do |gem|
  gem.name          = "sitegen"
  gem.version       = Sitegen::VERSION
  gem.authors       = ["Scott Windsor"]
  gem.email         = ["swindsor@gmail.com"]
  gem.description   = %q{A static site generator}
  gem.summary       = %q{An AMAZING static site generator}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('rake')
  gem.add_dependency('minitest')
  gem.add_dependency('maruku')

end
