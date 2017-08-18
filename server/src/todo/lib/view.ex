defmodule Todo.Page do
  import Plug.Conn

  def render(conn, data, status) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(data))
  end
end
