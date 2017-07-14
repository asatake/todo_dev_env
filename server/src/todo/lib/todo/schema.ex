defmodule Todo.Lists do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :title, :description, :deadline, :completed, :inserted_at, :updated_at]}

  schema "list" do
    field :title, :string
    field :description, :string
    field :deadline, :string
    field :completed, :boolean, default: false

    timestamps()
  end

  def changeset(list, params \\ %{}) do
    list
    |> cast(params, [:title, :description, :deadline, :completed])
    |> validate_required([:title, :description, :deadline])
    |> validate_length(:title, max: 128)
  end
end
