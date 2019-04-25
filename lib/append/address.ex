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
    # I think that this should be removed
    # see comments above this functions definition for more on this
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
      :tel
      # alog doesn't have entry_id as a required_field, it just ensures that an
      # entry_id is added to the changeset.
      # see https://github.com/dwyl/alog/blob/master/lib/alog.ex#L112
      # :entry_id
    ])
  end

  # Ideally, we wouldn't require the user to create a function that they have to
  # call in their changeset function.
  # This is moved in alog, and can be updated for the non-macro approach so that
  # users will not need to do this.
  def insert_entry_id(address) do
    case Map.fetch(address, :entry_id) do
      {:ok, nil} -> %{address | entry_id: Ecto.UUID.generate()}
      _ -> address
    end
  end
end
