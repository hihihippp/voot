require "spec_helper"

describe Voot do
  let(:voot_path) { Tempfile.new("voot").path }

  describe ".load" do
    subject { Voot.load(voot_path) }

    context "when the file is empty" do
      it "fails to parse" do
        expect { Voot.load(voot_path) }.to raise_error(Parslet::ParseFailed)
      end
    end

    context "when the file does not contain a webvtt header" do
      before { File.open(voot_path, "w") { |file| file << "taco thursdays yo" } }

      it "fails to parse" do
        expect { Voot.load(voot_path) }.to raise_error(Parslet::ParseFailed)
      end
    end

    context "when the file contains a webvtt header" do
      before { File.open(voot_path, "w") { |file| file << "WEBVTT" } }

      its(:cues) { should be_empty }
      its(:header) { should be_nil }
      its(:path) { should == voot_path }
    end

    context "when the file contains a header" do
      before { File.open(voot_path, "w") { |file| file << "WEBVTT presents bob ross classics" } }

      its(:header) { should == "presents bob ross classics" }
    end

    context "when the file contains a junk-filled header" do
      before { File.open(voot_path, "w") { |file| file << "WEBVTT\ni liek ppokemans" } }

      it "fails to parse" do
        expect { Voot.load(voot_path) }.to raise_error(Parslet::ParseFailed)
      end
    end

    context "when the file contains cues" do
      before { File.open(voot_path, "w") { |file| file << "WEBVTT\n\n00:00.000 --> 00:00.000\ndrugboat" } }

      it { should have(1).cues }
    end
  end
end
