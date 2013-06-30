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

  its(:to_webvtt) { should == "00:01.000 --> 01:05.001" }
end
