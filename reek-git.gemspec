# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reek/git/version'

Gem::Specification.new do |spec|
  spec.name          = 'reek-git'
  spec.version       = Reek::Git::VERSION
  spec.authors       = ['Saulius Grigaitis', 'Masaki Takeuchi']
  spec.email         = ['saulius@necolt.com', 'm.ishihara@gmail.com']
  spec.summary       = %q{Reek for git diff.}
  spec.description   = %q{Reek for git diff.}
  spec.homepage      = 'https://github.com/sauliusgrigaitis/reek-git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'reek', '>= 4.7'
end
