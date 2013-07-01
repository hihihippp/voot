require "voot/cue"

module Voot
  class CueList < Array

    def to_webvtt
      sorted_cues.map(&:to_webvtt).join("\n\n")
    end

    private

    def sorted_cues
      sort_by { |cue| cue.cue_timing.start_timestamp }
    end
  end
end
