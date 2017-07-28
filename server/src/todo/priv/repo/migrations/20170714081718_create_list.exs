defmodule Todo.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:list) do
      add :title, :string, null: false
      add :description, :string
      add :deadline, :date, unique: true
      add :completed, :boolean, unique: true, default: false

      timestamps()
    end
  end
end
