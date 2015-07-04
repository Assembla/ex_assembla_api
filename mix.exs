defmodule AssemblaApi.Mixfile do
  use Mix.Project

  @github_url "https://github.com/Assembla/ex_assembla_api"

  def project do
    [app: :assembla_api,
     version: "0.1.0",
     elixir: "~> 1.0",
     description: "Assembla API client",
     package: package,
     source_url: @github_url,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    # {:oauth2cli, "~> 0.0"}
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev},
      {:httpoison, "~> 0.7"},
      {:poison,    "~> 1.4"}
    ]
  end

  defp package do
    [contributors: ["Vitalie Lazu"],
     licenses: ["MIT"],
     links: %{"Github" => @github_url}]
  end
end
