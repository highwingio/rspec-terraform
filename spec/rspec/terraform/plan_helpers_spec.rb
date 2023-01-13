require 'spec_helper'

RSpec.describe RSpec::Terraform::PlanHelpers do
  before :all do
    @plan = terraform_plan('files')
  end

  it "returns a plan successfully" do
    expect(@plan).to be_a(RubyTerraform::Models::Plan)
  end

  context "resources" do
    let(:buckets) { @plan.resource_changes_matching(type: "aws_s3_bucket") }
    let(:mod_bucket) { buckets.first.change.after }
    let(:default_bucket) { buckets.last.change.after }

    it "creates the required buckets" do
      expect(buckets.count).to eq(2)
      expect(buckets).to all(be_create)
    end

    it "uses the parameters passed" do
      expect(mod_bucket[:bucket]).to eq('most-definitely')
      expect(mod_bucket.dig(:tags, :Environment)).to eq('My Brain Hurts')
    end

    it "uses defaults" do
      expect(default_bucket[:bucket]).to eq('please-no')
    end
  end
end