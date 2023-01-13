require_relative 'plan_helpers'

RSpec.configure do |config|
  config.add_setting :terraform_binary, default: "/Users/`whoami`/.asdf/shims/terraform"
  config.add_setting :terraform_examples_dir, default: "examples"
  config.add_setting :silence_terraform_output, default: false

  config.include(RSpec::Terraform::PlanHelpers)
end