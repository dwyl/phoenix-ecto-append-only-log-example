defmodule Append.Repo.Migrations.AddDeleted do
  use Ecto.Migration

  def change do
    alter table("addresses") do
      add(:deleted, :boolean, default: false)
    end
  end
end
