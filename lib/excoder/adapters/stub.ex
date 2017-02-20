defmodule Excoder.Adapters.Stub do
  @moduledoc """
  This module represents a stub transcoder adapter.
  """

  def transcode(job), do: {:ok, job}
end
