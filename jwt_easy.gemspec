# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jwt_easy/version'

Gem::Specification.new do |spec|
  spec.name          = 'jwt_easy'
  spec.version       = JWTEasy::VERSION
  spec.authors       = ['Collaboration Collective']
  spec.email         = ['hello@collabcollective.com']

  spec.summary       = 'jwt_easy'
  spec.description   = 'Library for generating and consuming JSON web tokens easily.'
  spec.homepage      = 'https://github.com/collcoll/jwt-easy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'

  spec.add_dependency 'jwt', '~> 2.7'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'timecop'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
