defmodule Iconv do
  @moduledoc """
  A set of function wrappers around the `iconv` command line utility.
  """



  def detect_file_encoding(file_path) do
    case System.cmd("uchardet", [file_path]) do
      {encoding, 0} -> {:ok, String.trim(encoding)}
      {_, 1} -> {:error, :detection_failed}
    end
  end
end
