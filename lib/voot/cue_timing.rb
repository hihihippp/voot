require "voot/timestamp"

module Voot
  class CueTiming
    attr_reader :start_timestamp, :stop_timestamp

    def initialize(start_timestamp, stop_timestamp)
      @start_timestamp = start_timestamp
      @stop_timestamp = stop_timestamp
    end

    def to_webvtt
      start_timestamp.to_webvtt << " --> " << stop_timestamp.to_webvtt
    end

    def cover?(seconds)
      seconds.between?(start_timestamp.seconds_since_origin, stop_timestamp.seconds_since_origin)
    end
  end
end
