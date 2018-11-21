use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :append, AppendWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :append, Append.Repo,
migration_timestamps: [type: :naive_datetime_usec],
  username: "append_only",
  password: "postgres",
  database: "append_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
