# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eRM,
  ecto_repos: [ERM.Repo]
  #generators: [binary_id: true]


# Configures the endpoint
config :eRM, ERMWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DUOMt9ALB/omANsflWOvF9q6IKvVyBm+8sh/NLoFTgB/rX61JxiKRl36Lff48BfU",
  render_errors: [view: ERMWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ERM.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
