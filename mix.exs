defmodule Exrtm.Mixfile do
  use Mix.Project

  def project do
    [ app: :exrtm,
      version: "0.0.1",
      elixir: "~> 0.10.0",
      name: "Exrtm",
      source_url: "https://github.com/parroty/exrtm",
      homepage_url: "https://github.com/parroty/exrtm",
      deps: deps ]
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
      {:mock, ">= 0.0.3", github: "parroty/mock"},
      {:ex_doc, github: "elixir-lang/ex_doc"},
      {:exactor, github: "sasa1977/exactor"},
      {:exprintf, github: "parroty/exprintf"},
      {:excoveralls, github: "parroty/excoveralls"}
    ]
  end
end
