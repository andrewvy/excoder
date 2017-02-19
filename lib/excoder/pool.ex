defmodule Excoder.Pool do
  @moduledoc """
  Module for handling the pool of `ffmpeg` worker processes.
  """

  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [])
  end


  def init(_options) do
    pool_options = [
      name: {:local, :excoder_pool},
      worker_module: Excoder.Worker,
      size: pool_size(),
      max_overflow: pool_size()
    ]

    children = [
      :poolboy.child_spec(:excoder_pool, pool_options, [])
    ]

    supervise(children, strategy: :one_for_one)
  end

  # Simple API wrapper around poolboy's methods.
  def checkout(), do: :poolboy.checkout(:excoder_pool)
  def checkin(worker), do: :poolboy.checkin(:excoder_pool, worker)
  def transaction(func), do: :poolboy.transaction(:excoder_pool, func)

  def encode(file_path) do
    transaction(fn(worker) ->
      worker |> Excoder.Worker.encode(file_path) |> IO.inspect
    end)
  end

  # Configuration
  defp pool_size(), do: Application.get_env(:excoder, Excoder)[:pool_size] || 8
end
