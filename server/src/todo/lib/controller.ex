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
