# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flue/version'

Gem::Specification.new do |gem|
  gem.name          = "flue"
  gem.version       = Flue::VERSION
  gem.authors       = ["Scott Windsor"]
  gem.email         = ["swindsor@gmail.com"]
  gem.description   = %q{A static site generator}
  gem.summary       = %q{An AMAZING static site generator}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/).reject{|f| f =~ /example/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'rake'
  gem.add_dependency 'maruku'
  gem.add_dependency 'RedCloth'
  gem.add_dependency 'gemoji'
  gem.add_dependency 'sass'
  gem.add_dependency 'coffee-script'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'coderay'
  gem.add_dependency 'rack'
  gem.add_dependency 'thor'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'flay'
  gem.add_development_dependency 'flog'
  gem.add_development_dependency 'reek'
end
