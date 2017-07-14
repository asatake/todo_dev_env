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

    Todo.Controller.insert(data, conn)
  end

  delete "/api/todo/:id" do
    Todo.Controller.delete(id, conn)
  end

  match _ do
    Todo.Page.render_404(conn)
  end
end
