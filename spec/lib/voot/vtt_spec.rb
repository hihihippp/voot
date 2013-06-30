require "spec_helper"

describe Voot::Vtt do
  let(:vtt_path) { Tempfile.new("voot-file").path }

  subject(:vtt) { Voot::Vtt.new(path: vtt_path) }

  describe "#save" do
    context "when the file does not exist" do
      before { FileUtils.rm(vtt_path) }

      it "creates the file" do
        expect do
          vtt.save
        end.to change { File.exist?(vtt_path) }.to(true)
      end
    end

    context "when the file exists" do
      let(:pesky_user_data) { "hey guys tacos are great right" }

      before { File.write(vtt_path, pesky_user_data) }

      it "clobbers the file content" do
        expect do
          vtt.save
        end.to change { File.read(vtt_path) }.from(pesky_user_data)
      end
    end
  end

  describe "#has_header?" do
    before { vtt.header = header }

    context "when the header is an empty string" do
      let(:header) { "" }

      it { should_not have_header }
    end

    context "when the header is nil" do
      let(:header) { nil }

      it { should_not have_header }
    end

    context "when the header not empty or nil" do
      let(:header) { "geese on parade" }

      it { should have_header }
    end
  end

  describe "#to_webvtt" do
    context "when the header is empty" do
      its(:to_webvtt) { should == "WEBVTT\n\n" }
    end

    context "when the header has content" do
      before { vtt.header = "here is a video of abbey the cat" }

      its(:to_webvtt) { should == "WEBVTT here is a video of abbey the cat\n\n" }
    end

    context "when there is a cue" do
      before { vtt.cues << create_cue("not the drill!", 0, 2) }

      its(:to_webvtt) { should == "WEBVTT\n\n00:00.000 --> 00:02.000\nnot the drill!" }
    end
  end
end
