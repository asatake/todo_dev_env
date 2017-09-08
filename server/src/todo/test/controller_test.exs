defmodule Todo.ControllerTest do
  use ExUnit.Case
  use Plug.Test
  alias Todo.{Controller}

  test "show_all validate" do
    assert is_list(Controller.show_all)
  end

end
