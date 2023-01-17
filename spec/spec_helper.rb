# frozen_string_literal: true

require "rspec/terraform"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.terraform_examples_dir = "./spec/fixtures"
  config.silence_terraform_output = true


  include RSpec::Terraform::PlanHelpers
  config.before :suite do
    terraform_init("spec/fixtures/files")
  end
end
