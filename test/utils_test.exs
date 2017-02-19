defmodule Excoder.UtilsTest do
  use ExUnit.Case

  @raw_log "frame=196\nfps=61.9\nstream_0_0_q=31.0\nbitrate= 840.8kbits/s\ntotal_size=307182\nout_time_ms=2922667\nout_time=00:00:02.922667\ndup_frames=2\ndrop_frames=0\nspeed=0.923x\nprogress=continue\n"

  test "Can parse ffmpeg progress log" do
    parsed_log = @raw_log |> Excoder.Utils.parse_ffmpeg_output()
    expected_log = %{
      "frame" => "196",
      "fps" => "61.9",
      "stream_0_0_q" => "31.0",
      "bitrate" => "840.8kbits/s",
      "total_size" => "307182",
      "out_time_ms" => "2922667",
      "out_time" => "00:00:02.922667",
      "dup_frames" => "2",
      "drop_frames" => "0",
      "speed" => "0.923x",
      "progress" => "continue"
    }

    assert parsed_log == expected_log
  end
end
