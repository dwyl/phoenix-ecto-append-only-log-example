defmodule Append.AddressTest do
  use Append.DataCase
  alias Append.Address

  test "add item to database" do
    assert {:ok, item} = insert_address()

    assert item.name == "Thor"
  end

  describe "get item from database" do
    test "get/1" do
      {:ok, item} = insert_address()

      assert Address.get(item.entry_id) == item
    end
  end

  test "update item in database" do
    {:ok, item} = insert_address()

    {:ok, updated_item} = Address.update(item, %{tel: "0123444444"})

    assert updated_item.name == item.name
    assert updated_item.tel != item.tel
  end

  test "get updated item" do
    {:ok, item} = insert_address()

    {:ok, updated_item} = Address.update(item, %{tel: "0123444444"})

    assert Address.get(item.entry_id) == updated_item
  end

  test "get history of item" do
    {:ok, item} = insert_address()

    {:ok, updated_item} =
      Address.update(item, %{
        address_line_1: "12",
        address_line_2: "Kvadraturen",
        city: "Oslo",
        postcode: "NW SCA"
      })

    history = Address.get_history(updated_item)

    assert length(history) == 2
    assert [h1, h2] = history
    assert Map.fetch(h1, :city) == {:ok, "Asgard"}
    assert Map.fetch(h2, :city) == {:ok, "Oslo"}
  end

  def insert_address do
    Address.insert(%{
      name: "Thor",
      address_line_1: "The Hall",
      address_line_2: "Valhalla",
      city: "Asgard",
      postcode: "AS1 3DG",
      tel: "0800123123"
    })
  end

  describe "delete:" do
    test "deleted items are not retrieved with 'get'" do
      {:ok, item} = insert_address()
      {:ok, _} = Address.delete(item)

      assert Address.get(item.entry_id) == nil
    end
  end
end
