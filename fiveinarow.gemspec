# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fiveinarow/version'

Gem::Specification.new do |spec|
  spec.name          = "fiveinarow"
  spec.version       = Fiveinarow::VERSION
  spec.authors       = ["Tomáš Nesrovnal"]
  spec.email         = ["nesro@nesro.cz"]

  spec.summary       = %q{Five in a row (Gomoku like board game)}
  spec.description   = %q{Five in a row is a classic board game. You need to make a line of five to win.}
  spec.homepage      = "https://github.com/nesro/fiveinarow"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "gosu", "~> 0.10.5"
  spec.add_development_dependency "rspec-core", "~> 3.4"
  spec.add_development_dependency "rspec", "~> 0"
end
