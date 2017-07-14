defmodule Todo.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    plug_adapter = Plug.Adapters.Cowboy
    # Define workers and child supervisors to be supervised
    children = [
      plug_adapter.child_spec(:http, Todo.Router, [], [port: 4000]),
      supervisor(Todo.Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Todo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
