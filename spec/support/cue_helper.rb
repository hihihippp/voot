module CueHelper
  def create_cue(payload, start, stop)
    cue_timing = Voot::CueTiming.new(start_seconds: start, end_seconds: stop)
    Voot::Cue.new(cue_timing: cue_timing, payload: payload)
  end
end
