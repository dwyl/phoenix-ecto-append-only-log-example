defmodule Append.AddressTest do
  use Append.DataCase
  alias Append.Address

  test "add item to database" do
    assert {:ok, item} = insert_address()

    assert item.name == "Thor"
  end

  describe "get items from database" do
    test "get/1" do
      # {:ok, item} = insert_address()
      {:ok, item} = insert_address2()

      assert Address.get(item.entry_id) == item
    end

    test "all/0" do
      insert_address()
      {:ok, loki} = insert_address2("Loki")
      assert length(Address.all()) == 2

      {:ok, loki2} = insert_address("Loki")

      # remove things that will always be different
      [m1, m2] =
        [loki, loki2]
        |> Enum.map(&Map.drop(&1, ~w(entry_id id inserted_at updated_at)a))

      # This test shows that insert_address and insert_address2 both return the
      # same value
      # check out where insert_address amd insert_address2 are defined below to
      # see differences between the two functions. (There isn't many)
      assert Map.equal?(m1, m2)
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

  test "all/0 does not include old items" do
    {:ok, item} = insert_address()
    {:ok, _} = insert_address("Loki")
    {:ok, _} = Address.update(item, %{postcode: "W2 3EC"})

    assert length(Address.all()) == 2
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

  # macro way
  def insert_address(name \\ "Thor") do
    Address.insert(%{
      name: name,
      address_line_1: "The Hall",
      address_line_2: "Valhalla",
      city: "Asgard",
      postcode: "AS1 3DG",
      tel: "0800123123"
    })
  end

  # function way
  def insert_address2(name \\ "Thor") do
    Append.AOL.insert(Address, %{
      name: name,
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

    test "deleted items are not retrieved with 'all'" do
      {:ok, item} = insert_address()
      {:ok, _} = Address.delete(item)

      assert length(Address.all()) == 0
    end
  end
end
