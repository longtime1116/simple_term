
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "term/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_term"
  spec.version       = Term::VERSION
  spec.authors       = ["longtime1116"]
  spec.email         = ["longtime1116@gmail.com"]

  spec.summary       = %q{This gem provides the minimum necessary functions to manage term.}
  spec.description   = %q{You can manage the beginning and ending date time of a term. You can also check whether two terms are overlapped. When the beginning or ending date time is indefinite, you can represent it by nil.}
  spec.homepage      = "https://github.com/longtime1116/simple_term"
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
