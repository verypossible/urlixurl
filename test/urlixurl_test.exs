defmodule UrlixurlTest do
  use ExUnit.Case
  doctest Urlixurl

  test "url search should strip off domains" do
    results = Urlixurl.search("news.example.com")
    assert length(results) == 2

    results = Urlixurl.search("example.com")
    assert length(results) == 1
  end

  test "url search builds a result for each domain subset" do
    assert [] == Urlixurl.search("com")

    result = Urlixurl.search("example.com")
    assert ["example.com"] == result

    results = Urlixurl.search("news.example.com")
    assert ["news.example.com", "example.com"] == results
  end

  test "url search should strip off subdirectories" do
    results = Urlixurl.search("example.com/foo/bar")
    assert length(results) == 3
  end

  test "url search builds a result for each directory subset" do
    results = Urlixurl.search("example.com/test")
    assert ["example.com/test", "example.com"] == results
  end

  test "it orders directories before subdomains" do
    results = Urlixurl.search("news.example.com/test")
    assert ["news.example.com/test", "news.example.com", "example.com"] == results
    results = Urlixurl.search("example.com/test/this")
    assert ["example.com/test/this", "example.com/test", "example.com"] == results
  end
  test "it strips off a trailing /" do
    results = Urlixurl.search("example.com/")
    assert ["example.com"] == results
  end
  test "it strips off a leading protocol" do
    results = Urlixurl.search("https://example.com")
    assert ["example.com"] == results
    results = Urlixurl.search("ftp://example.com")
    assert ["example.com"] == results
  end
end

