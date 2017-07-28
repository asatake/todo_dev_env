defmodule Todo.SchemaTest do
  use ExUnit.Case
  use Plug.Test
  alias Todo.Lists

  test "changeset with valid attributes" do
    changeset = %Lists{}
    |> Lists.changeset(%{title: "test_title",
                        description: "test description",
                        deadline: "2018-01-01",
                        completed: false})
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = %Lists{}
    |> Lists.changeset(%{title: "jugemujugemugokonosurikirekaijarisuigyonosuigyomatsuunraimatsufuraimatsukunerutokoronisumutokoroyaburakojiburakojipaipopaipopaiponoshuringan",
                        description: "",
                        deadline: "2017-01-01",
                        completed: true})
    assert {_, [_, validation: :length, max: 128]} = changeset.errors[:title]
    refute changeset.valid?
  end

  test "changeset with invalid completed type" do
    changeset = %Lists{}
    |> Lists.changeset(%{title: "",
                        description: "",
                        deadline: "",
                        completed: 1})
    refute changeset.valid?
  end
end
