defmodule Append.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field(:address_line_1, :string)
    field(:address_line_2, :string)
    field(:city, :string)
    field(:name, :string)
    field(:postcode, :string)
    field(:tel, :string)

    timestamps()
  end

  # Because we are referencing the Address struct in our Append Only behaviour/macro
  # it needs to be used after we have defined the struct using 'schema'
  use Append.AppendOnlyLog

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :address_line_1, :address_line_2, :city, :postcode, :tel])
    |> validate_required([:name, :address_line_1, :address_line_2, :city, :postcode, :tel])
  end
end
