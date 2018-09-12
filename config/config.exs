# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :append,
  ecto_repos: [Append.Repo]

# Configures the endpoint
config :append, AppendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GO2SbHTQj2fUfrYvH+TfJxHF4jB9bn+yWZEIjFCECLG/mW2zZz1/iBLLUT+FlgjD",
  render_errors: [view: AppendWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Append.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
