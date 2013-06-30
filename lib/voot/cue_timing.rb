module Voot
  class CueTiming
    attr_reader :start_seconds, :end_seconds

    def initialize(options = {})
      @start_seconds = options.fetch(:start_seconds)
      @end_seconds = options.fetch(:end_seconds)
    end

    def to_webvtt
      "#{format_timestamp(start_seconds)} --> #{format_timestamp(end_seconds)}"
    end

    private

    def format_timestamp(seconds)
      "#{format_minutes(seconds)}:#{format_seconds(seconds)}.#{format_subseconds(seconds)}"
    end

    def format_minutes(seconds)
      (seconds.to_i / 60).to_s.rjust(2, "0")
    end

    def format_seconds(seconds)
      (seconds.to_i % 60).to_s.rjust(2, "0")
    end

    def format_subseconds(seconds)
      ((seconds * 1000).round % 1000).to_s.rjust(3, "0")
    end
  end
end
