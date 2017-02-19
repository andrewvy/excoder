defmodule Excoder.Structs.Video do
  defstruct [
    file_path: nil,
    output_path: "output.mp4",
    ffmpeg_options: [],
    total_frame_count: 0,
    progress: 0.0
  ]

  @type t :: %__MODULE__{
    file_path: String.t,
    output_path: String.t,
    ffmpeg_options: [String.t] | [],
    total_frame_count: non_neg_integer(),
    progress: float()
  }
end
