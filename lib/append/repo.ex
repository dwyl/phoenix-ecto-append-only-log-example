defmodule Append.Repo do
  use Ecto.Repo,
    otp_app: :append,
    adapter: Ecto.Adapters.Postgres
end
