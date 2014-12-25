# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vam/version'

Gem::Specification.new do |spec|
  spec.name          = 'vam'
  spec.version       = Vam::VERSION
  spec.authors       = ['Xingjian Xu']
  spec.email         = ['dotswing@gmail.com']
  spec.summary       = %q{Vendor assets managment}
  spec.description   = %q{Vendor assets managment tool}
  spec.homepage      = 'http://github.com/dotswing/vam'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.1'

  spec.add_runtime_dependency 'colorize', '~> 0.7'
end
