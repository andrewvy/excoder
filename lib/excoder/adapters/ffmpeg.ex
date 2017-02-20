defmodule Excoder.Adapters.FFMPEG do
  @moduledoc """
  This module implements the Transcoder behaviour
  for an ffmpeg back-end.
  """

  @behaviour Excoder.Transcoder

  def transcode(job) do
    {:ok, job}
  end
end
