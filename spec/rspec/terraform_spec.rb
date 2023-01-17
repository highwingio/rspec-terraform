# frozen_string_literal: true
require 'spec_helper'

RSpec.describe RSpec::Terraform do
  it "has a version number" do
    expect(Rspec::Terraform::VERSION).not_to be nil
  end
end
