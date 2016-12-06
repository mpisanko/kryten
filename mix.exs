defmodule Kryten.Mixfile do
  use Mix.Project

  def project do
    [app: :kryten,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :slack],
     mod: {Kryten, []}]
  end

  defp deps do
    [
      {:slack, "~> 0.9.0"}
    ]
  end
end
