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

  test "call TLDR with a OS X non existing term" do
    use_cassette "tldr_osx_non_existing_term" do
      assert capture_io(fn -> TLDR.main(["ls"]) end) =~ ~r/List all files with their rights, groups, owner/
    end
  end

  test "call TLDR with a OS X existing term" do
    use_cassette "tldr_osx_existing_term" do
      assert capture_io(fn -> TLDR.main(["brew"]) end) =~ ~r/Package manager for OS X/
    end
  end
end
