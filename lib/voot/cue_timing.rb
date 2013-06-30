module Voot
  class CueTiming
    attr_reader :start_seconds, :end_seconds

    def initialize(options = {})
      @start_seconds = options.fetch(:start_seconds).to_f.round(3)
      @end_seconds = options.fetch(:end_seconds).to_f.round(3)
    end

    def to_webvtt
      "#{format_timestamp(start_seconds)} --> #{format_timestamp(end_seconds)}"
    end

    def cover?(seconds)
      (start_seconds..end_seconds).cover?(seconds)
    end

    private

    def format_timestamp(seconds)
      if seconds > 3600
        "#{format_hours(seconds)}:#{format_minutes(seconds)}:#{format_seconds(seconds)}.#{format_subseconds(seconds)}"
      else
        "#{format_minutes(seconds)}:#{format_seconds(seconds)}.#{format_subseconds(seconds)}"
      end
    end

    def format_hours(seconds)
      (seconds.to_i / 3600).to_s.rjust(2, "0")
    end

    def format_minutes(seconds)
      ((seconds.to_i % 3600) / 60).to_s.rjust(2, "0")
    end

    def format_seconds(seconds)
      (seconds.to_i % 60).to_s.rjust(2, "0")
    end

    def format_subseconds(seconds)
      ((seconds * 1000).round % 1000).to_s.rjust(3, "0")
    end
  end
end
