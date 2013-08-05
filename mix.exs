defmodule Exrtm.Mixfile do
  use Mix.Project

  def project do
    [ app: :exrtm,
      version: "0.0.1",
      elixir: "~> 0.10.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:mock, ">= 0.0.3", [github: "jjh42/mock"]}]
  end
end
