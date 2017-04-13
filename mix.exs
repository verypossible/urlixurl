defmodule Urlixurl.Mixfile do
  use Mix.Project

  def project do
    [
      app: :urlixurl,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      dialyzer: [
        flags: ["-Wunmatched_returns", :error_handling, :race_conditions, :underspecs],
        plt_add_deps: :transitive,
      ],
    deps: deps(),
    description: """
    Splits a url into semantically useful representations of itself.
    """,
    package: package(),
    ]
  end

  defp package do
    [
      maintainers: ["Jeff McGehee", "Michael Simpson"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/spartansystems/urlixurl"},
     ]
  end
  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:logger]
    ]
  end
  defp deps do
    [
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:credo, "~> 0.5", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end
end
