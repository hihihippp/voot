require "spec_helper"

describe Voot::Parser do
  subject(:parser) { Voot::Parser.new }

  it { should parse("WEBVTT") }
  it { should parse("WEBVTT\n\n") }

  describe "#header" do
    specify { parser.header.should parse("WEBVTT").as(header: []) }
    specify { parser.header.should parse("WEBVTT - goose hugs").as(header: "- goose hugs") }
  end

  describe "#subseconds" do
    specify { parser.subseconds.should parse("164").as(subseconds: "164") }
  end

  describe "#seconds" do
    specify { parser.seconds.should parse("66.").as(seconds: "66") }
  end

  describe "#minutes" do
    specify { parser.minutes.should parse("01:").as(minutes: "01") }
  end

  describe "#hours" do
    specify { parser.hours.should parse("13:").as(hours: "13") }
    specify { parser.hours.should parse("9000:").as(hours: "9000") }
  end

  describe "#timestamp_without_hours" do
    specify { parser.timestamp_without_hours.should parse("01:33.007").as(minutes: "01", seconds: "33", subseconds: "007") }
  end

  describe "#timestamp_with_hours" do
    specify { parser.timestamp_with_hours.should parse("11:59:59.999").as(hours: "11", minutes: "59", seconds: "59", subseconds: "999") }
  end

  describe "#timestamp" do
    specify { parser.timestamp.should parse("01:33.007").as(minutes: "01", seconds: "33", subseconds: "007") }
    specify { parser.timestamp.should parse("11:59:59.999").as(hours: "11", minutes: "59", seconds: "59", subseconds: "999") }
  end

  describe "#timing_delimiter" do
    specify { parser.timing_delimiter.should parse("-->") }
  end

  describe "#cue_timing" do
    specify { parser.cue_timing.should parse("01:33.007 -->\t 11:59:59.999").as(start: anything, stop: anything) }
  end

  describe "#cue_identifier" do
    specify { parser.cue_identifier.should_not parse("drugboats --> ahoy") }
    specify { parser.cue_identifier.should_not parse("puppet\npals") }
    specify { parser.cue_identifier.should parse("evil squid cult").as(identifier: "evil squid cult") }
  end

  describe "#cue_payload" do
    specify { parser.cue_payload.should parse("once upon a dingus").as(payload: "once upon a dingus") }
    specify { parser.cue_payload.should parse("there were\nan prancess").as(payload: "there were\nan prancess") }
    specify { parser.cue_payload.should_not parse("whare is\n\nlazy prance") }
  end

  describe "#cue_without_identifier" do
    specify { parser.cue_without_identifier.should parse("00:00.000 --> 00:30.000\nget to the choppa?").as(start: anything, stop: anything, payload: anything) }
  end

  describe "#cue_with_identifier" do
    specify { parser.cue_with_identifier.should parse("777\n00:00.000 --> 00:30.000\njhonny paints the wall").as(identifier: anything, start: anything, stop: anything, payload: anything) }
  end

  describe "#cue" do
    specify { parser.cue.should parse("the hablet\n00:00.000 --> 00:30.000\nwelcam ashire\nbalbo").as(identifier: anything, start: anything, stop: anything, payload: anything) }
    specify { parser.cue.should parse("04:00.000 --> 55:30.000\n(tom belmadal sings)").as(start: anything, stop: anything, payload: anything) }
  end

  describe "#file_body" do
    specify { parser.file_body.should parse("WEBVTT").as(header: [], cues: []) }
    specify { parser.file_body.should parse("WEBVTT\n\n00:00.000 --> 00:00.000\nhi").as(header: [], cues: [anything]) }
    specify { parser.file_body.should parse("WEBVTT\n\n00:00.000 --> 00:00.000\nlike\n\n00:01.000 --> 00:01.000\nwut").as(header: [], cues: [anything, anything]) }
  end
end
