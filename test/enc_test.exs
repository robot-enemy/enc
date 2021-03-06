defmodule EncTest do
  use ExUnit.Case
  doctest Enc

  describe "detect_file_encoding/1" do

    test "correctly detects encodings" do
      encodings = [
        "ASCII",
        "BIG5",
        "EUC-JP",
        "EUC-KR",
        "GB18030",
        "IBM855",
        "IBM866",
        "ISO-8859-2-HUNGARIAN",
        "ISO-8859-5-BULGARIAN",
        "ISO-8859-5-CYRILLIC",
        "ISO-8859-7-GREEK",
        "KOI8-R",
        "MacCyrillic",
        "SHIFT_JIS",
        "TIS-620",
        "UTF-8",
        "WINDOWS-1250-HUNGARIAN",
        "WINDOWS-1251-BULGARIAN",
        "WINDOWS-1251-CYRILLIC",
        "WINDOWS-1255-HEBREW",
      ]

      for encoding <- encodings do
        file_path = Path.join([__DIR__, "data", encoding])
        # => /test/data/UTF-8

        file_paths = file_path |> File.ls!() |> Enum.map(&Path.join(file_path, &1))
        # => ["/test/data/UTF-8/1.xml", "/test/data/UTF-8/2.xml"]

        for file_path <- file_paths do
          assert {:ok, encoding} = Enc.detect_file_encoding(file_path)
        end
      end
    end

  end

  #
  # These test are incorrect.  Need some concrete examples to against our actual
  # usage.
  #

  # describe "detect_string_encoding/1" do

  #   test "correctly detects the encoding of a string" do
  #     str = "EMMANUEL PE\xc3\u0192\xc2\u2018A GOMEZ PORTUGAL"

  #     assert {:ok, "WINDOWS-1252"} = Enc.detect_string_encoding(str)
  #   end

  # end

  # describe "strip_non_unicode_characters/1" do

  #   test "strips non-unicode characters from a string" do
  #     str = "EMMANUEL PE\xc3\u0192\xc2\u2018A GOMEZ PORTUGAL"

  #     assert {:ok, "EMMANUEL PE_ƒ_‘A GOMEZ PORTUGAL"} = Enc.strip_non_unicode_characters(str)
  #   end
  # end

end
