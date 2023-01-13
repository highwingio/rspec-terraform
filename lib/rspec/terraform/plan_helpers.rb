# frozen_string_literal: true

module RSpec
  module Terraform
    module PlanHelpers
      def self.included(_mod)
        RubyTerraform.configure do |c|
          c.binary = RSpec.configuration.terraform_binary
          c.stdout = Logger.new(IO::NULL) if RSpec.configuration.silence_terraform_output
        end
      end

      def terraform_plan(example_dir = "")
        raw = plan(example_dir) { show(_1) }
        RubyTerraform::Models::Plan.new(JSON.parse(raw.read, symbolize_names: true))
      end

      private

      def plan(example_name)
        Tempfile.create(example_name) do |io|
          RubyTerraform.plan(chdir: File.join(RSpec.configuration.terraform_examples_dir, example_name), out: io.path)
          yield io
        end
      end

      def show(plan_file)
        raw_plan_output = StringIO.new
        RubyTerraform::Commands::Show.new(stdout: raw_plan_output)
                                     .execute(path: plan_file.path, json: true)

        raw_plan_output.rewind
        raw_plan_output
      end
    end
  end
end
