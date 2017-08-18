# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :todo, Todo.Repo,
  adapter: Ecto.Adapters.MySQL,
  database: "todo",
  username: "root",
  password: "asa/Test00",
  hostname: "db"

config :todo, Todo.TestRepo,
  adapter: Ecto.Adapters.MySQL,
  database: "todo_test",
  username: "root",
  password: "asa/Test00",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

config :todo,
  ecto_repos: [Todo.Repo, Todo.TestRepo]

