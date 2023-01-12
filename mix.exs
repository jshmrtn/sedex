# credo:disable-for-this-file Credo.Check.Readability.Specs
defmodule Sedex.MixProject do
  @moduledoc false

  use Mix.Project

  @version "1.0.3"

  def project do
    [
      app: :sedex,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      build_embedded:
        Mix.env() == :prod or System.get_env("BUILD_EMBEDDED", "false") in ["1", "true"],
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      dialyzer:
        if (System.get_env("DIALYZER_PLT_PRIV") || "false") in ["1", "true"] do
          [plt_file: {:no_warn, "priv/plts/dialyzer.plt"}]
        else
          []
        end
    ]
  end

  defp description do
    """
    Library to work with Sedex.
    """
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Sedex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jose, "~> 1.11"},
      {:ex_aws, "~> 2.1"},
      {:ex_aws_s3, "~> 2.0"},
      {:sweet_xml, "~> 0.6"},
      {:erlsom, "~> 1.5"},
      {:briefly, "~> 0.4.1", only: [:test]},
      {:ex_doc, "~> 0.19", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.5", only: [:test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:credo, "~> 1.0", only: [:dev], runtime: false}
    ]
  end

  defp package do
    # These are the default files included in the package
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*", "priv/schema/*.xsd"],
      maintainers: ["Jonatan Männchen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jshmrtn/sedex"}
    ]
  end

  defp docs do
    [
      source_ref: "v" <> @version,
      source_url: "https://github.com/jshmrtn/sedex",
      extras: [
        "CHANGELOG.md"
      ]
    ]
  end
end
