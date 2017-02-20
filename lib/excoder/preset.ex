defmodule Excoder.VideoPreset do
  @moduledoc """
  This struct represents a transcoding preset
  for video.
  """

  defstruct [
    :height,
    :width,
    :codec
  ]

  @type t :: %__MODULE__{
    height: non_neg_integer(),
    width: non_neg_integer(),
    codec: String.t
  }
end

defmodule Excoder.AudioPreset do
  @moduledoc """
  This struct represents a transcoding preset
  for audio.
  """

  defstruct [
    :codec,
    :bitrate
  ]

  @type t :: %__MODULE__{
    codec: String.t,
    bitrate: non_neg_integer()
  }
end

defmodule Excoder.OutputPreset do
  @moduledoc """
  This struct represents a transcoding preset.
  """

  defstruct [
    video: %Excoder.VideoPreset{},
    audio: %Excoder.AudioPreset{},
  ]


  @type t :: %__MODULE__{
    video: Excoder.VideoPreset.t,
    audio: Excoder.AudioPreset.t
  }
end
