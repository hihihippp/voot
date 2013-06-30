# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'voot/version'

Gem::Specification.new do |spec|
  spec.name          = "voot"
  spec.version       = Voot::VERSION
  spec.authors       = ["Doc Ritezel"]
  spec.email         = ["doc@minifast.co"]
  spec.description   = %q{WebVTT generation, parsing and manipulation}
  spec.summary       = %q{Easily create, read and write WebVTT files}
  spec.homepage      = "https://github.com/minifast/voot"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- bin`.split("\n").map { |f| File.basename(f) }
  spec.test_files    = `git ls-files -- spec`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "gem-release"
end
