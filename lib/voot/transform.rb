require "parslet"

module Voot
  class Transform < Parslet::Transform
    rule(:minutes => simple(:minutes), :seconds => simple(:seconds), :subseconds => simple(:subseconds)) do
      (minutes.to_i * 60) + seconds.to_i + (subseconds.to_i / 1000.0)
    end

    rule(:hours => simple(:hours), :minutes => simple(:minutes), :seconds => simple(:seconds), :subseconds => simple(:subseconds)) do
      (hours.to_i * 3600) + (minutes.to_i * 60) + seconds.to_i + (subseconds.to_i / 1000.0)
    end

    rule(:start => simple(:start), :stop => simple(:stop), :payload => simple(:payload)) do
      cue_timing = Voot::CueTiming.new(start_seconds: start, end_seconds: stop)
      Voot::Cue.new(cue_timing: cue_timing, payload: payload.to_s)
    end

    rule(:start => simple(:start), :stop => simple(:stop), :payload => simple(:payload), :identifier => simple(:identifier)) do
      cue_timing = Voot::CueTiming.new(start_seconds: start, end_seconds: stop)
      Voot::Cue.new(cue_timing: cue_timing, payload: payload.to_s, identifier: identifier.to_s)
    end

    rule(:header => sequence(:header), :cues => sequence(:cues)) do
      vtt = Voot::Vtt.new
      cues.each { |cue| vtt.cues << cue }
      vtt
    end

    rule(:header => simple(:header), :cues => sequence(:cues)) do
      vtt = Voot::Vtt.new(header: header)
      cues.each { |cue| vtt.cues << cue }
      vtt
    end
  end
end
