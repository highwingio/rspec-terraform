# frozen_string_literal: true

require "tempfile"

module RSpec
  module Terraform
    # Module to supply helpers to the rspec context when working with terraform plans
    module PlanHelpers
      def self.included(_mod)
        RubyTerraform.configure do |c|
          c.binary = RSpec.configuration.terraform_binary
          c.stdout = Logger.new(IO::NULL) if RSpec.configuration.silence_terraform_output
        end
      end

      # Run terraform init as needed (automatically called by `terraform_plan`)
      # @param [String] full_path
      def terraform_init(full_path)
        RubyTerraform.init(chdir: full_path)
      end

      # Run a terraform plan and return a new Plan object
      # @param [String] example_path example directory name to run
      def terraform_plan(example_path = "")
        full_path = example_path(example_path)
        terraform_init(full_path)

        raw = create_plan(full_path) { show(full_path, _1) }
        RubyTerraform::Models::Plan.new(JSON.parse(raw.read, symbolize_names: true))
      end

      private

      # @param [String] example_path example directory name to run
      def create_plan(example_path, &block)
        Tempfile.create(example_path) do |io|
          RubyTerraform.plan(chdir: example_path, out: io.path)
          yield io
        end
      end

      # @param [String] example_path directory scope to run terraform within
      # @param [IO] plan_file IO object to read plan data from
      def show(example_path, plan_file)
        raw_plan_output = StringIO.new
        RubyTerraform::Commands::Show.new(stdout: raw_plan_output)
                                     .execute(chdir: example_path, path: plan_file.path, json: true)

        raw_plan_output.rewind
        raw_plan_output
      end

      def example_path(example_name)
        File.join(RSpec.configuration.terraform_examples_dir, example_name)
      end
    end
  end
end
