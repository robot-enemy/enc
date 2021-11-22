defmodule Iconv do
  @moduledoc """
  A set of function wrappers around the `iconv` command line utility.
  """
  @detect_script_path  Path.join(__DIR__, "../scripts/detect-string")



  def detect_file_encoding(file_path) do
    case System.cmd("uchardet", [file_path]) do
      {encoding, 0} -> {:ok, String.trim(encoding)}
      {_, 1} -> {:error, :detection_failed}
    end
  end

  def detect_string_encoding(str) do
    case System.cmd(@detect_script_path, [str]) do
      {encoding, 0} -> {:ok, String.trim(encoding)}
      {_, 1}        -> {:ok, :detection_failed}
    end
  end
end
