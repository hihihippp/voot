require "spec_helper"

describe Voot::CueList do
  subject(:cue_list) { Voot::CueList.new }

  describe "#to_webvtt" do
    context "when the list is empty" do
      its(:to_webvtt) { should be_empty }
    end

    context "when the list has an item in it" do
      before { cue_list << create_cue("reasonably priced", 0, 0) }

      its(:to_webvtt) { should == "00:00:00.000 --> 00:00:00.000\nreasonably priced" }

      context "when the list has multiple items" do
        before { cue_list << create_cue("toiletries", 1, 1) }

        its(:to_webvtt) { should include "00:00:01.000 --> 00:00:01.000\ntoiletries" }

        it "separates cues with a double newline" do
          cue_list.to_webvtt.should == <<-ALL_THE_CUES.strip
00:00:00.000 --> 00:00:00.000
reasonably priced

00:00:01.000 --> 00:00:01.000
toiletries
          ALL_THE_CUES
        end

        it "orders the cues by start time" do
          cue_list << create_cue("hair spray", 0.5, 1)
          cue_list.to_webvtt.should == <<-ALL_THE_CUES.strip
00:00:00.000 --> 00:00:00.000
reasonably priced

00:00:00.500 --> 00:00:01.000
hair spray

00:00:01.000 --> 00:00:01.000
toiletries
          ALL_THE_CUES
        end
      end
    end
  end
end
