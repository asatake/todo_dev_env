defmodule Todo.PostTest do
  import Ecto.Query
  use ExUnit.Case
  use Plug.Test
  use Timex
  alias Todo.{Lists, TestRepo}

  setup_all do
    %Lists{}
    |> Lists.changeset(%{title: "test", description: "test data", deadline: "2018-01-01", completed: false})
    |> TestRepo.insert!
    on_exit fn ->
      TestRepo.one(from l in Lists, limit: 1,  select: l)
      |> TestRepo.delete!
      :ok
    end
    :ok
  end

  test "update title valid?" do
    assert {:ok, _} =
      TestRepo.one!(from l in Lists, limit: 1,  select: l)
      |> Lists.changeset(%{title: "test2"})
      |> TestRepo.update
    result = TestRepo.one!(from l in Lists, limit: 1,  select: l)
     assert "test2" = result.title
  end

  test "update description valid?" do
    assert {:ok, _} =
      TestRepo.one!(from l in Lists, limit: 1,  select: l)
      |> Lists.changeset(%{description: "description2"})
      |> TestRepo.update
    result = TestRepo.one!(from l in Lists, limit: 1,  select: l)
    assert "description2" = result.description
  end

  test "update deadline valid?" do
    assert {:ok, _} =
      TestRepo.one!(from l in Lists, limit: 1,  select: l)
      |> Lists.changeset(%{deadline: ~D[2018-09-09]})
      |> TestRepo.update
    result = TestRepo.one!(from l in Lists, limit: 1,  select: l)
    assert ~D[2018-09-09] = result.deadline
  end

  test "update completed valid?" do
    assert {:ok, _} =
      TestRepo.one!(from l in Lists, limit: 1,  select: l)
      |> Lists.changeset(%{completed: true})
      |> TestRepo.update
    result = TestRepo.one!(from l in Lists, limit: 1,  select: l)
    assert true = result.completed
  end
end
