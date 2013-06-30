require "spec_helper"

describe Voot::Transform do
  let(:cue_timing) { Voot::CueTiming.new(start_seconds: 61.001, end_seconds: 3661.001) }
  let(:parser) { Voot::Parser.new }

  subject(:transformed) { Voot::Transform.new.apply(parsed_input) }

  describe "#timestamp" do
    let(:parsed_input) { parser.timestamp.parse(input_string) }

    context "when the timestamp does not have hours" do
      let(:input_string) { "01:01.001" }

      it { should == 61.001 }
    end

    context "when the timestamp has hours" do
      let(:input_string) { "01:01:01.001" }

      it { should == 3661.001 }
    end
  end

  describe "#cue_timing" do
    let(:input_string) { cue_timing.to_webvtt }
    let(:parsed_input) { parser.cue_timing.parse(input_string) }

    it { should == {start: 61.001, stop: 3661.001} }
  end

  describe "#cue" do
    let(:parsed_input) { parser.cue.parse(cue.to_webvtt) }

    context "when there is an identifier" do
      let(:cue) { Voot::Cue.new(cue_timing: cue_timing, identifier: "ferdo", payload: "hes also too an habblet") }

      its(:identifier) { should == "ferdo" }
      its(:payload) { should == "hes also too an habblet" }
      its(:cue_timing) { should cover 61.001 }
      its(:cue_timing) { should cover 3661.001 }
    end

    context "when there is no identifier" do
      let(:cue) { Voot::Cue.new(cue_timing: cue_timing, payload: "gordolf he is a beard") }

      its(:identifier) { should be_nil }
      its(:payload) { should == "gordolf he is a beard" }
      its(:cue_timing) { should cover 61.001 }
      its(:cue_timing) { should cover 3661.001 }
    end
  end

  describe "#file_body" do
    let(:vtt) { Voot::Vtt.new.tap { |vtt| vtt.cues << cue } }
    let(:cue) { Voot::Cue.new(cue_timing: cue_timing, payload: "borgomar is a dumb") }
    let(:parsed_input) { parser.file_body.parse(vtt.to_webvtt) }

    context "when the header is not set" do

      its(:header) { should be_nil }
      its(:cues) { should have(1).cue }
    end

    context "when the header is set" do
      before { vtt.header = "lerd of rang" }

      its(:header) { should == "lerd of rang" }
      its(:cues) { should have(1).cue }
    end
  end
end
