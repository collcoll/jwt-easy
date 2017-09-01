# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jwt_easy/version'

Gem::Specification.new do |spec|
  spec.name          = 'jwt_easy'
  spec.version       = JWTEasy::VERSION
  spec.authors       = ['Lawrance Shepstone']
  spec.email         = ['lawrance.shepstone@gmail.com']

  spec.summary       = 'jwt_easy'
  spec.description   = 'Library for generating and consuming JSON web tokens easily.'
  spec.homepage      = 'https://github.com/lshepstone/jwt_easy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'jwt', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0'
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'timecop', '~> 0'
end
