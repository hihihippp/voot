require "spec_helper"

describe Voot::CueTiming do
  let(:start_seconds) { 1.0001 }
  let(:end_seconds) { 65.0009 }

  subject(:cue_timing) do
    Voot::CueTiming.new(
      start_seconds: start_seconds,
      end_seconds: end_seconds
    )
  end

  describe "#to_webvtt" do
    context "when the timestamps do not have hours" do
      its(:to_webvtt) { should == "00:01.000 --> 01:05.001" }
    end

    context "when the end timestamp has hours" do
      let(:end_seconds) { 3601.1 }
      its(:to_webvtt) { should == "00:01.000 --> 01:00:01.100" }
    end
  end

  describe "#cover?" do
    it { should cover 1.000 }
    it { should cover 65.001 }
  end
end
