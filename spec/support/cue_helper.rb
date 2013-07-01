module CueHelper
  def create_timing(start, stop)
    start_timestamp = Voot::Timestamp.new(start)
    stop_timestamp = Voot::Timestamp.new(stop)
    Voot::CueTiming.new(start_timestamp, stop_timestamp)
  end

  def create_cue(payload, start, stop)
    cue_timing = create_timing(start, stop)
    Voot::Cue.new(cue_timing: cue_timing, payload: payload)
  end
end
