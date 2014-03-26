defmodule TLDR.Mixfile do
  use Mix.Project

  def project do
    [ app: :tldr,
      version: "0.0.2",
      name: "TLDR",
      elixir: "~> 0.12.5",
      escript_main_module: TLDR,
      deps: deps(Mix.env) ]
  end

  def application do
    [ applications: [ :httpoison ] ]
  end

  defp deps(:prod) do
    [ { :httpoison, github: "edgurgel/httpoison", tag: "0.0.2" } ]
  end
  defp deps(:test) do
    deps(:prod) ++ [ {:exvcr, github: "parroty/exvcr"} ]
  end
  defp deps(:dev), do: deps(:prod)
end
