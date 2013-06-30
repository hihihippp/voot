require "voot/cue"

module Voot
  class CueList < Array

    def to_webvtt
      map(&:to_webvtt).join("\n\n")
    end
  end
end
