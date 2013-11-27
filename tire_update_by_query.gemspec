# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tire_update_by_query/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["kaka"]
  gem.email         = ["huxinghai1988@gmail.com"]
  gem.description   = %q{elasticsearch update by query}
  gem.summary       = %q{elasticsearch update by query}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tire_update_by_query"
  gem.require_paths = ["lib"]
  gem.version       = TireUpdateByQuery::VERSION
  gem.add_dependency "tire"
  gem.add_development_dependency "bundler"
  gem.add_development_dependency "rake"
end
