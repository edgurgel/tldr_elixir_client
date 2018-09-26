defmodule TLDR do
  use HTTPoison.Base
  import IO.ANSI
  require Logger

  def main(args) do
    args |> parse_args |> process |> IO.puts()
  end

  defp parse_args(args) do
    options = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])

    case options do
      {[help: true], _, _} ->
        :help

      {_, [], _} ->
        :help

      {_, terms, _} ->
        Enum.join(terms, " ") |> String.trim()
    end
  end

  defp process(:help) do
    """
    Usage:
      tldr term
    Options:
      -h, [--help]  # Show this help message and quit.

    Description:
      Search for a definition on TLDR.
    """
  end

  defp process(""), do: process(:help)
  defp process(term), do: describe(current_os(), term)

  def process_url(url) do
    "https://raw.githubusercontent.com/tldr-pages/tldr/master/pages/" <> url
  end

  def process_request_headers(headers), do: headers ++ [{"User-agent", "TLDR Elixir client"}]

  defp current_os do
    case OS.type() do
      {:win32, _} -> :common
      {:unix, :darwin} -> :osx
      {:unix, :sunos} -> :sunos
      {:unix, :linux} -> :linux
      _ -> :common
    end
  end

  defp describe(os, term) do
    {:ok, response} = get("#{os}/#{term}.md")
    if response.status_code == 404 do
      if os == :common do
        "Not found"
      else
        describe(:common, term)
      end
    else
      response.body |> format_md
    end
  end

  defp format_md(markdown) do
    String.split(markdown, ~r/\n/)
    |> Enum.drop(2)
    |> Enum.map(fn line ->
      [[format_line(line) | reset()] | "\n"]
    end)
    |> IO.ANSI.format(true)
  end

  defp format_line("> " <> line) do
    [:white, line]
  end

  defp format_line("- " <> line) do
    [:green, line]
  end

  defp format_line("`" <> line) do
    [:black_background, :white, String.trim_trailing(line, "`")]
  end

  defp format_line(line), do: [line]
end
