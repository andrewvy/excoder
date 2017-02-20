defmodule Excoder.Transcoder do
  @moduledoc """
  This module defines the Transcoder behaviour inherited by
  excoder adapters.

  These methods are called as part of the normal Excoder.Pool
  workers.
  """

  @type success :: {:ok, Excoder.Job.t}
  @type error :: {:error, Excoder.Job.t}

  @callback transcode(Excoder.Job.t) :: success | error
end
