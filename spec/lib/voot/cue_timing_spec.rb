require "spec_helper"

describe Voot::CueTiming do
  let(:start_timestamp) { Voot::Timestamp.new(1.0001) }
  let(:stop_timestamp) { Voot::Timestamp.new(65.0009) }

  subject(:cue_timing) { Voot::CueTiming.new(start_timestamp, stop_timestamp) }

  its(:to_webvtt) { should == "00:00:01.000 --> 00:01:05.001" }

  describe "#cover?" do
    it { should cover 1.000 }
    it { should cover 65.001 }
  end
end
