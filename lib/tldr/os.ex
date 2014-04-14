defmodule OS do
  @moduledoc """
  This module is just a thin wrapper on `os` Erlang module
  It's necessary to mock (using meck) the call to `type`
  """

  @doc """
  Thin wrapper on `os` Erlang module
  """
  def type, do: :os.type
end
