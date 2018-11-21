defmodule Append.Address do
  use Ecto.Schema
  import Ecto.Changeset
  use Append.AppendOnlyLog

  @timestamps_opts [type: :naive_datetime_usec]
  schema "addresses" do
    field(:address_line_1, :string)
    field(:address_line_2, :string)
    field(:city, :string)
    field(:name, :string)
    field(:postcode, :string)
    field(:tel, :string)
    field(:entry_id, :string)
    field(:deleted, :boolean, default: false)

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> insert_entry_id()
    |> cast(attrs, [
      :name,
      :address_line_1,
      :address_line_2,
      :city,
      :postcode,
      :tel,
      :entry_id,
      :deleted
    ])
    |> validate_required([
      :name,
      :address_line_1,
      :address_line_2,
      :city,
      :postcode,
      :tel,
      :entry_id
    ])
  end

  def insert_entry_id(address) do
    case Map.fetch(address, :entry_id) do
      {:ok, nil} -> %{address | entry_id: Ecto.UUID.generate()}
      _ -> address
    end
  end
end
