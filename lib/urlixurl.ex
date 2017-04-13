defmodule Urlixurl do
  @moduledoc """
  A library for working with URLs
  """

  @doc """
  Search for permutations of a url

  ## Examples

      iex> Urlixurl.search("https://foo.bar.com/baz/bang/")
      ["foo.bar.com/baz/bang", "foo.bar.com/baz", "foo.bar.com", "bar.com"]

  """
  def search(url) do
    [subdomains | dirs] =
      url
      |> String.trim_trailing("/")
      |> String.split("://")
      |> List.last()
      |> String.split("/")

    subdomain_list = subdomains |> subdomain_search()
    dirs |> Enum.reduce(subdomain_list, &build_subdirs/2)
  end

  defp subdomain_search(url) do
    url
    |> String.split(".")
    |> build_urls([])
  end

  defp build_urls([_url], queries) do
    queries
    |> Enum.reverse()
  end
  defp build_urls(url_domains, queries) do
    query_url = Enum.join(url_domains, ".")

    build_urls(Enum.drop(url_domains, 1), [query_url | queries])
  end

  defp build_subdirs([], _), do: []
  defp build_subdirs(dir, [last_query|_] = acc) do
    [last_query <> "/" <> dir | acc]
  end
  defp build_subdirs(_, _), do: []
end

