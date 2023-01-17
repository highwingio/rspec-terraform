# frozen_string_literal: true

require_relative "lib/rspec/terraform/version"

Gem::Specification.new do |spec|
  spec.name = "rspec-terraform"
  spec.version = RSpec::Terraform::VERSION
  spec.authors = ["plukevdh"]
  spec.email = ["luke.vanderhoeven@highwing.io"]

  spec.summary = "RSpec Unit testing for Terraform plans"
  spec.description = "This project provides RSpec helpers for unit testing terraform plan output."
  spec.homepage = "https://github.com/highwingio/rspec-terraform"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "ruby-terraform", "~> 1.7"
end
