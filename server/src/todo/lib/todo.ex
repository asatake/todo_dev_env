defmodule Todo.Router do
  use Plug.Router
  alias Todo.{Page, Controller}

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:urlencoded]
  plug :match
  plug :dispatch

  # all
  get "/api/todo" do
    result = Controller.show_all()
    Page.render(conn, result, 200)
  end

  # completed
  get "/api/todo/completed" do
    result = Controller.show_completed()
    Page.render(conn, result, 200)
  end

  # where id = ?
  get "/api/todo/:id" do
    result = Controller.show_one(id)
    Page.render(conn, result, 200)
  end

  put "/api/todo/:id" do
    title = if conn.params["title"], do: conn.params["title"], else: nil
    description = if conn.params["description"], do: conn.params["description"], else: nil
    deadline = if conn.params["deadline"], do: conn.params["deadline"], else: nil
    completed = if conn.params["completed"], do: conn.params["completed"], else: nil
    data = %{id: id, title: title, description: description, deadline: deadline, completed: completed}

    case Controller.update(id, data) do
      true -> Page.render(conn, %{"message": "update success!"}, 204)
      false -> Page.render(conn, %{"message": "update failure!"}, 409)
    end
  end

  post "/api/todo" do
    title = conn.params["title"]
    description = conn.params["description"]
    deadline = conn.params["deadline"]
    data = %{title: title, description: description, deadline: deadline}

    case Controller.insert(data) do
      true -> Page.render(conn, %{"message": "insert success!"}, 201)
      false -> Page.render(conn, %{"message": "insert failure!"}, 409)
    end
  end

  delete "/api/todo/:id" do
    case Controller.delete(id) do
      true -> Page.render(conn, %{"message": "delete success!"}, 204)
      false -> Page.render(conn, %{"message": "delete failure!"}, 409)
      :not_found -> Page.render(conn, %{"message": "data not found."}, 404)
    end
  end

  match _ do
    Page.render(conn, %{"message": "Not Found."}, 404)
  end
end
