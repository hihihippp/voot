require "spec_helper"

describe Voot::Timestamp do
  subject(:timestamp) { Voot::Timestamp.new(seconds) }

  describe "#<=>" do
    let(:seconds) { 1.1 }

    context "when comparing against the number of seconds" do
      it { should == seconds }
    end

    context "when comparing against another timestamp" do
      let(:other) { double(:timestamp, seconds_since_origin: seconds) }

      it { should == other }
    end
  end

  describe "#seconds_since_origin" do
    context "when the seconds can round up" do
      let(:seconds) { 0.0005 }

      it "rounds the seconds to the nearest millisecond" do
        timestamp.seconds_since_origin.should == 0.001
      end
    end

    context "when the seconds can round up" do
      let(:seconds) { 0.0014 }

      it "rounds the seconds to the nearest millisecond" do
        timestamp.seconds_since_origin.should == 0.001
      end
    end
  end

  describe "#hours" do
    let(:seconds) { 3600 }

    it "returns the number of hours in the timestamp" do
      timestamp.hours.should == 1
    end
  end

  describe "#minutes" do
    let(:seconds) { 120 }

    it "returns the number of minutes in the timestamp" do
      timestamp.minutes.should == 2
    end
  end

  describe "#seconds" do
    let(:seconds) { 3 }

    it "returns the number of seconds in the timestamp" do
      timestamp.seconds.should == 3
    end
  end

  describe "#milliseconds" do
    let(:seconds) { 0.004 }

    it "returns the number of milliseconds in the timestamp" do
      timestamp.milliseconds.should == 4
    end

    context "when milliseconds can round up" do
      let(:seconds) { 0.0045 }

      it "returns the rounded-up number of milliseconds in the timestamp" do
        timestamp.milliseconds.should == 5
      end
    end

    context "when milliseconds can round down" do
      let(:seconds) { 0.0031 }

      it "returns the rounded-down number of milliseconds in the timestamp" do
        timestamp.milliseconds.should == 3
      end
    end
  end

  describe "#to_webvtt" do
    let(:seconds) { 3723.004 }

    its(:to_webvtt) { should == "01:02:03.004" }
  end
end
