defmodule Todo.Mixfile do
  use Mix.Project

  def project do
    [app: :todo,
     version: "0.1.0",
     elixir: "~> 1.4",
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :ecto, :mariaex, :cowboy, :plug, :poison, :timex],
     mod: {Todo.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ecto, "~> 2.0"},
      {:mariaex, "~> 0.8"},
      {:cowboy, "1.0.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:timex, "~> 3.1"},
      {:coverex, "~> 1.4.10", only: :test},
      {:excoveralls, "~> 0.7", only: :test}
    ]
  end
end
