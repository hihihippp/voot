require "parslet"

module Voot
  class Transform < Parslet::Transform
    rule(:minutes => simple(:minutes), :seconds => simple(:seconds), :subseconds => simple(:subseconds)) do
      Voot::Timestamp.new((minutes.to_i * 60) + seconds.to_i + (subseconds.to_i / 1000.0))
    end

    rule(:hours => simple(:hours), :minutes => simple(:minutes), :seconds => simple(:seconds), :subseconds => simple(:subseconds)) do
      Voot::Timestamp.new((hours.to_i * 3600) + (minutes.to_i * 60) + seconds.to_i + (subseconds.to_i / 1000.0))
    end

    rule(:start => simple(:start_timestamp), :stop => simple(:stop_timestamp), :payload => simple(:payload)) do
      cue_timing = Voot::CueTiming.new(start_timestamp, stop_timestamp)
      Voot::Cue.new(cue_timing: cue_timing, payload: payload.to_s)
    end

    rule(:start => simple(:start_timestamp), :stop => simple(:stop_timestamp), :payload => simple(:payload), :identifier => simple(:identifier)) do
      cue_timing = Voot::CueTiming.new(start_timestamp, stop_timestamp)
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
