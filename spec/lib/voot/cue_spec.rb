require "spec_helper"

describe Voot::Cue do
  let(:identifier) { "taco massacre" }
  let(:payload) { "tasty" }
  let(:cue_timing) { Voot::CueTiming.new(start_seconds: 0, end_seconds: 1) }

  subject(:cue) do
    Voot::Cue.new(
      identifier: identifier,
      cue_timing: cue_timing,
      payload: payload
    )
  end

  describe "#has_identifier?" do
    context "when the identifier is set" do
      it { should have_identifier }
    end

    context "when the identifier is nil" do
      let(:identifier) { nil }

      it { should_not have_identifier }
    end

    context "when the identifier is an empty string" do
      let(:identifier) { "" }

      it { should_not have_identifier }
    end
  end

  describe "#to_webvtt" do
    context "when the identifier is set" do
      its(:to_webvtt) { should == "taco massacre\n00:00.000 --> 00:01.000\ntasty" }
    end

    context "when the identifier is not set" do
      let(:identifier) { nil }

      its(:to_webvtt) { should == "00:00.000 --> 00:01.000\ntasty" }
    end
  end
end
