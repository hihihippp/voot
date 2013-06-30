require "parslet"

module Voot
  class Parser < Parslet::Parser
    rule(:line_break) { match("[\r\n]|\r\n") }
    rule(:whitespace) { match("[\s\t]") }
    rule(:section_separator) { line_break.repeat(2) }

    rule(:header_string) { (line_break.absent? >> any).repeat }
    rule(:header) { str("WEBVTT") >> whitespace.repeat >> header_string.as(:header) }

    rule(:digit) { match("[0-9]") }
    rule(:colon) { match("[:]") }
    rule(:period) { match("[.]") }

    rule(:hours) { digit.repeat(2).as(:hours) >> colon }
    rule(:minutes) { digit.repeat(2, 2).as(:minutes) >> colon }
    rule(:seconds) { digit.repeat(2, 2).as(:seconds) >> period }
    rule(:subseconds) { digit.repeat(3, 3).as(:subseconds) }

    rule(:timestamp_without_hours) { minutes >> seconds >> subseconds }
    rule(:timestamp_with_hours) { hours >> minutes >> seconds >> subseconds }

    rule(:timestamp) { timestamp_without_hours | timestamp_with_hours }

    rule(:timing_delimiter) { str("-->") }
    rule(:cue_timing) { timestamp.as(:start) >> whitespace.repeat(1) >> timing_delimiter >> whitespace.repeat(1) >> timestamp.as(:stop) }

    rule(:cue_identifier) { (line_break.absent? >> timing_delimiter.absent? >> any).repeat.as(:identifier) }

    rule(:cue_payload) { (section_separator.absent? >> any).repeat.as(:payload) }

    rule(:cue_without_identifier) { cue_timing >> line_break >> cue_payload }
    rule(:cue_with_identifier) { cue_identifier >> line_break >> cue_timing >> line_break >> cue_payload }

    rule(:cue) { cue_without_identifier | cue_with_identifier }
    rule(:cue_list) { (section_separator >> cue).repeat }

    rule(:file_body) { header >> cue_list.as(:cues) >> line_break.repeat }

    root(:file_body)
  end
end
