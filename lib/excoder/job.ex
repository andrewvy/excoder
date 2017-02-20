defmodule Excoder.JobOutput do
  @moduledoc """
  Represents an output for a job.
  """

  defstruct [
    :output_url,
    :preset
  ]

  @type t :: %__MODULE__{
    output_url: String.t,
    preset: Excoder.OutputPreset.t
  }
end

defmodule Excoder.Job do
  @moduledoc """
  This is a video transcoding job.

  submitted_at: Time when the job was submitted to us
  started_at: Time when the job was submitted to the adapter
  updated_at: Time when the job was last updated (?)
  completed_at: Time when the job was completed

  """

  defstruct [
    :uuid,
    :source_url,
    :submitted_at,
    :started_at,
    :updated_at,
    :completed_at,
    :progress,
    :outputs
  ]

  @type t :: %__MODULE__{
    uuid: String.t,
    source_url: String.t,
    submitted_at: DateTime.t,
    started_at: DateTime.t,
    updated_at: DateTime.t,
    completed_at: DateTime.t,
    progress: float(),
    outputs: Excoder.JobOutput.t
  }
end
