defmodule Excoder.Worker do
	use GenServer
  require Logger

  def start_link(_options) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_options) do
    {:ok, []}
  end

  def encode(pid, file_path) do
    {:ok, frame_count} = Excoder.Utils.get_frame_count_of_file(file_path)

    video = %Excoder.Structs.Video{
      file_path: file_path,
      output_path: "output.mp4",
      ffmpeg_options: [
        "-v", "quiet",
        "-progress", "/dev/stdout",
        "-i", file_path,
        "-f", "mp4",
        "-acodec", "aac",
        "-preset", "fast",
        "-nostdin",
        "output.mp4"
      ],
      total_frame_count: frame_count
    }

    Logger.info("Started video encoding for: #{file_path}")

    pid |> GenServer.call({:start, video})
  end

  def handle_call({:start, video}, _from, _state) do
    VideoProcessor.start_link({video, self()})

    {:reply, :ok, video}
  end

  def handle_call(:ping, _from, state) do
    {:reply, :pong, state}
  end

  def handle_call(:get_progress, _from, state) do
    {:reply, state.progress, state}
  end

  def handle_info({:progress, log}, state) do
    new_state =
      log
      |> Excoder.Utils.parse_ffmpeg_output()
      |> update_progress(state)

    Logger.info("Progress: #{new_state.progress |> Float.round(3)}%")

    {:noreply, new_state}
  end

  defp update_progress(parsed_progress, state) do
    current_frame = (parsed_progress["frame"] || "0") |> String.to_integer
    total_frame_count = state.total_frame_count

    state
    |> Map.put(:progress, current_frame / total_frame_count)
  end
end
