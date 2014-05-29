defmodule Exrtm.Mixfile do
  use Mix.Project

  def project do
    [ app: :exrtm,
      version: "0.1.0",
      elixir: "~> 0.13.3",
      name: "Exrtm",
      source_url: "https://github.com/parroty/exrtm",
      homepage_url: "https://github.com/parroty/exrtm",
      deps: deps,
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  def application do
#   [mod: {Exrtm, []}]
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:meck, github: "eproxus/meck", tag: "0.8.2"},
      {:mock, ">= 0.0.3", github: "parroty/mock", branch: "version"},
      {:exactor, github: "sasa1977/exactor"},
      {:exprintf, "0.1.0"},
      {:excoveralls, "0.2.1"}
    ]
  end
end
