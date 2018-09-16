defmodule Append.Repo.Migrations.AddEntryId do
  use Ecto.Migration

  def change do
    alter table("addresses") do
      add :entry_id, :string
    end

  end
end
