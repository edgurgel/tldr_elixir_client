defmodule TLDR.TLDRTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import ExUnit.CaptureIO

  test "call TLDR with an empty argument" do
    assert capture_io(fn -> TLDR.main([""]) end) =~ ~r/Usage:/
  end

  test "call TLDR with no argument" do
    assert capture_io(fn -> TLDR.main([]) end) =~ ~r/Usage:/
  end

  test "call TLDR with one word argument" do
    use_cassette "tldr_one_argument" do
      assert capture_io(fn -> TLDR.main(["ls"]) end) =~ ~r/List all files with their rights, groups, owner/
    end
  end
end
