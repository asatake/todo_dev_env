defmodule Todo.ControllerTest do
  use ExUnit.Case
  use Plug.Test
  alias Todo.{Lists, Controller}

  @valid_data %{title: "test", description: "test data", deadline: "2018-01-01", completed: false}

  test "insert validate" do
    assert @valid_data
    |> Controller.insert
  end

  test "show_all validate" do
    assert is_list(Controller.show_all)
  end

  test "show_one" do
    ret = Controller.show_one(1)
    assert is_integer ret.id
    assert is_bitstring ret.title
    assert is_boolean ret.completed
  end
end
