defmodule TLDR.TLDRTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import ExUnit.CaptureIO
  import :meck

  setup do
    new OS
  end

  teardown do
    unload OS
  end

  test "call TLDR with an empty argument" do
    assert capture_io(fn -> TLDR.main([""]) end) =~ ~r/Usage:/
  end

  test "call TLDR with no argument" do
    assert capture_io(fn -> TLDR.main([]) end) =~ ~r/Usage:/
  end

  test "call TLDR with a OS X non existing term" do
    expect(OS, :type, 0, {:unix, :darwin})

    use_cassette "tldr_osx_non_existing_term" do
      assert capture_io(fn -> TLDR.main(["ls"]) end) =~ ~r/List all files with their rights, groups, owner/
    end

    assert validate OS
  end

  test "call TLDR with a OS X existing term" do
    expect(OS, :type, 0, {:unix, :darwin})

    use_cassette "tldr_osx_existing_term" do
      assert capture_io(fn -> TLDR.main(["brew"]) end) =~ ~r/Package manager for OS X/
    end

    assert validate OS
  end
end
