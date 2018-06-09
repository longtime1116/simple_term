
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "term/version"

Gem::Specification.new do |spec|
  spec.name          = "term"
  spec.version       = Term::VERSION
  spec.authors       = ["longtime1116"]
  spec.email         = ["longtime1116@gmail.com"]

  spec.summary       = %q{This gem helps you manage terms.}
  spec.description   = %q{Create the instances of Term class and manage terms}
  spec.homepage      = "https://github.com/longtime1116/term"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
