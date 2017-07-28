defmodule Todo.Router do
  use Plug.Router

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:urlencoded]
  plug :match
  plug :dispatch

  # all
  get "/api/todo" do
    result = Todo.Controller.show_all()
    Todo.Page.render(conn, result, 200)
  end

  # completed
  get "/api/todo/completed" do
    result = Todo.Controller.show_completed()
    Todo.Page.render(conn, result, 200)
  end

  # where id = ?
  get "/api/todo/:id" do
    result = Todo.Controller.show_one(id)
    Todo.Page.render(conn, result, 200)
  end

  post "/api/todo" do
    title = conn.params["title"]
    description = conn.params["description"]
    deadline = conn.params["deadline"]
    data = %{title: title, description: description, deadline: deadline}

    case Todo.Controller.insert(data) do
      true -> Page.render(conn, %{"message": "insert success!"}, 201)
      false -> Page.render(conn, %{"message": "insert failure!"}, 400)
    end
  end

  delete "/api/todo/:id" do
    case Todo.Controller.delete(id) do
      true -> Page.render(conn, %{"message": "delete success!"}, 204)
      false -> Page.render(conn, %{"message": "delete failure!"}, 400)
      :not_found -> Page.render(conn, %{"message": "data not found."}, 404)
    end
  end

  match _ do
    Todo.Page.render_404(conn)
  end
end
