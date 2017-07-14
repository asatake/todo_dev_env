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

  def insert(data, conn) do
    changeset = Lists.changeset(%Lists{},
      %{title: data.title,
        description: data.description,
        deadline: data.deadline
      }
    )
    case Repo.insert(changeset) do
      {:ok, _} -> Page.render(conn, %{"message": "insert success!"}, 201)
      {:error, _} -> Page.render(conn, %{"message": "insert error!"}, 500)
    end
  end

  def delete(id, conn) do
    case Repo.get(Lists, id) do
      nil -> Todo.Page.render_404(conn)
      record -> case Repo.delete(record) do
                  {:ok, _} -> Page.render(conn, %{"message": "delete success!"}, 204)
                  {:error, _} -> Page.render(conn, %{"message": "delete error!"}, 500)
                end
    end
  end

end
