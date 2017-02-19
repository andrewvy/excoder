defmodule VideoProcessor do
  @moduledoc """
  Wraps the ffmpeg process and streams progress stout logs to a linked process.
  """

  use GenServer

  def start_link({_video, _parent_pid} = state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    Process.send_after(self(), :start, 10)

    {:ok, state}
  end

  def handle_info(:start, {video, parent_pid} = state) do
    opts = [
      out: :stream,
      err: :out
    ]

    %Porcelain.Process{out: outstream} = Porcelain.spawn("ffmpeg", video.ffmpeg_options, opts)

    outstream
    |> Stream.each(&IO.inspect/1)
    |> Stream.each(&(send_to_parent(parent_pid, &1)))
    |> Stream.run

    {:noreply, state}
  end

  def send_to_parent(parent_pid, log), do: parent_pid |> send({:progress, log})
end
