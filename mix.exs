defmodule TLDR.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tldr,
      version: "0.0.2",
      name: "TLDR",
      elixir: "~> 0.15.1 or ~> 1.0.0 or 1.7.0",
      escript: [main_module: TLDR],
      deps: deps()
    ]
  end

  def application do
    [applications: [:httpoison, :logger]]
  end

  defp deps do
    [{:httpoison, "~> 1.0"}]
  end
end
