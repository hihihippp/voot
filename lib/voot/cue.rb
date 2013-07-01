require "voot/cue_timing"

module Voot
  class Cue
    attr_reader :identifier, :cue_timing, :payload

    def initialize(options = {})
      @identifier = options[:identifier]
      @cue_timing = options.fetch(:cue_timing)
      @payload = options.fetch(:payload)
    end

    def has_identifier?
      !identifier.nil? && identifier.length > 0
    end

    def to_webvtt
      output = ""
      output << identifier << "\n" if has_identifier?
      output << cue_timing.to_webvtt << "\n" << payload
    end
  end
end
