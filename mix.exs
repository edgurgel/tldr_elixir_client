defmodule TLDR.Mixfile do
  use Mix.Project

  def project do
    [ app: :tldr,
      version: "0.0.2",
      name: "TLDR",
      elixir: "~> 0.15.1",
      escript: [ main_module: TLDR],
      deps: deps ]
  end

  def application do
    [ applications: [ :httpoison ] ]
  end

  defp deps do
    [ { :httpoison, github: "edgurgel/httpoison", tag: "0.3.2" },
      { :exvcr, "~> 0.3.0", only: :test },
      { :meck, "0.8.2", github: "eproxus/meck", override: true, only: :test } ]
  end
end
