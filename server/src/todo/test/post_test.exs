defmodule Todo.PostTest do
  use ExUnit.Case
  use Plug.Test
  alias Todo.{Lists, TestRepo}

  @valid_data %{title: "test", description: "test data", deadline: "2018-01-01", completed: false}

  setup do
    %Lists{}
    |> Lists.changeset(@valid_data)
    |> TestRepo.insert!
    :ok
  end

  test "insert valid?" do
    assert {:ok, _} = %Lists{}
    |> Lists.changeset(@valid_data)
    |> TestRepo.insert
  end

  test "insert invalid?" do
    catch_error %Lists{}
    |> Lists.changeset(%{})
    |> TestRepo.insert
  end

  # test "update title valid?" do
  #   assert {:ok, _} = %Lists{}
  #   |> Lists.changeset(%{title: "test2"})
  #   |> Repo.update
  # end

  # test "update description valid?" do
  #   assert {:ok, _} = %Lists{}
  #   |> Lists.changeset(%{description: "test update data"})
  #   |> Repo.update
  # end

  # test "update deadline valid?" do
  #   assert {:ok, _} = %Lists{}
  #   |> Lists.changeset(%{deadline: "2017-12-31"})
  #   |> Repo.update
  # end

  # test "update completed valid?" do
  #   assert {:ok, _} = %Lists{}
  #   |> Lists.changeset(%{completed: true})
  #   |> Repo.update
  # end
end
