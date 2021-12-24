defmodule NearApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :near_api,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  defp description do
    """
    An Elixir library for DApps development on the NEAR blockchain platform
    """
  end

  defp package do
    [
      maintainers: ["Alex Filatov"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/alexfilatov/near_api",
        "Docs" => "https://hexdocs.pm/near_api"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:b58, "~> 1.0.2"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
    ]
  end
end
