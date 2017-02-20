defmodule Excoder.Utils do
  @doc """
  Returns the total frame count of a given file.
  """
  @spec get_frame_count_of_file(String.t) :: {:ok, non_neg_integer()} | {:error, non_neg_integer()}
  def get_frame_count_of_file(file_path) do
    ffprobe_options = [
      "-v", "error",
      "-select_streams", "v:0",
      "-show_entries", "stream=nb_frames",
      "-of", "default=nokey=1:noprint_wrappers=1",
      file_path
    ]

    case Porcelain.exec("ffprobe", ffprobe_options) do
      %Porcelain.Result{status: 0, out: frame_count} ->
        {:ok, frame_count |> String.strip() |> String.to_integer()}
      _ ->
        {:error, 0}
    end
  end

  @doc """
  Parses out an ffmpeg progress log into a map.
  """
  @spec parse_ffmpeg_output(String.t) :: map()
  def parse_ffmpeg_output(log) do
    log
    |> String.strip()
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(arg, acc) ->
      case String.split(arg, "=") do
        [arg_name, arg_value] -> Map.put(acc, String.strip(arg_name), String.strip(arg_value))
        _ -> acc
      end
    end)
  end
end
