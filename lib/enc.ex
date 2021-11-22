defmodule Enc do
  @moduledoc """
  A set of function wrappers around the `iconv` command line utility.
  """
  @convert_script_path Path.join(__DIR__, "../scripts/convert-string")
  @detect_script_path  Path.join(__DIR__, "../scripts/detect-string")

  def convert_file_encoding(file_path, from_enc, to_enc) do
    System.cmd("iconv", ["-f #{from_enc}", "-t #{to_enc}", file_path])
  end

  def convert_string_encoding(str, from_enc, to_enc) do
    System.cmd(@convert_script_path, [str, from_enc, to_enc])
  end

  def detect_file_encoding(file_path) do
    case System.cmd("uchardet", [file_path]) do
      {encoding, 0} -> {:ok, String.trim(encoding)}
      {_, 1}        -> {:error, :detection_failed}
    end
  end

  def detect_string_encoding(str) do
    case System.cmd(@detect_script_path, [str]) do
      {encoding, 0} -> {:ok, String.trim(encoding)}
      {_, 1}        -> {:ok, :detection_failed}
    end
  end

  def strip_non_unicode_characters(str) do
    case System.cmd(@convert_script_path, [str, "UTF-8", "UTF-8"]) do
      {result, 0} -> {:ok, String.trim(result)}
      {_, 1}      -> {:error, :strip_failed}
    end
  end

end
