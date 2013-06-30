require "voot/cue_list"

module Voot
  class Vtt
    attr_reader :path
    attr_accessor :header

    def initialize(options = {})
      @path = options.fetch(:path)
      @header = options[:header]
    end

    def cues
      @cues ||= Voot::CueList.new
    end

    def to_webvtt
      if has_header?
        "WEBVTT #{header}\n\n#{cues.to_webvtt}"
      else
        "WEBVTT\n\n#{cues.to_webvtt}"
      end
    end

    def has_header?
      !header.nil? && header.length > 0
    end

    def save
      ensure_destination_directory
      File.open(path, "w") { |destination| destination.write(to_webvtt) }
    end

    private

    def ensure_destination_directory
      FileUtils.mkdir_p(File.dirname(path))
    end
  end
end
