$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "constantizable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "constantizable"
  s.version     = Constantizable::VERSION
  s.authors     = ["Abhishek Sarkar", "Yuvaraja Balamurugan", "Nithin Krishna"]
  s.email       = ["abhishek@codebrahma.com","yuva@codebrahma.com","nithin@codebrahma.com"]
  s.summary     = %q{An elegant way to query constant tables, and inquire constant table objects.}
  s.description = %q{An elegant way to query constant tables, and inquire constant table objects.}
  s.homepage    = "http://codebrahma.com/constantizable"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "debugger", "~> 1.6.8"
end
