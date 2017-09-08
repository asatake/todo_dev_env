defmodule Todo.Controller do
  import Ecto.Query, only: [from: 2]
  alias Todo.{Lists, Repo, Page}

  def show_all() do
    query = from l in Lists,
      select: l
    Repo.all(query)
  end

  def show_one(id) do
    query = from l in Lists,
      select: l
    Repo.get(query, id)
  end

  def show_completed() do
    query = from l in Lists,
      where: l.completed == true,
      select: l
    Repo.all(query)
  end

  def insert(data) do
    changeset = Lists.changeset(%Lists{},
      %{title: data.title,
        description: data.description,
        deadline: data.deadline
      }
    )
    case Repo.insert(changeset) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  def update(id, data) do
    post = %{}
    if data.title != nil, do: post = Map.merge(post, %{title: data.title})
    if data.description != nil, do: post = Map.merge(post, %{description: data.description})
    if data.deadline != nil, do: post = Map.merge(post, %{deadline: data.deadline})
    if data.completed != nil, do: post = Map.merge(post, %{completed: data.completed})

    case Repo.one!(from l in Lists, where: l.id == id,  select: l)
    |> Lists.changeset(post)
    |> Repo.update do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  def delete(id) do
    case Repo.get(Lists, id) do
      nil -> :not_found
      record -> case Repo.delete(record) do
                  {:ok, _} -> true
                  {:error, _} -> false
                end
    end
  end

end
