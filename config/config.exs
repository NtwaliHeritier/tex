# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tex,
  ecto_repos: [Tex.Repo]

# Configures the endpoint
config :tex, TexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "00y2oA89NZqu8WXUEKHozZND1X1egKjgSsRbJJx1OD2Vw6wBY7K+Qdv0Si4ReQcP",
  render_errors: [view: TexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tex.PubSub,
  live_view: [signing_salt: "InJ1xowW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cloudex,
    api_key: "944869157288711",
    secret: "zZcAii5bQPwuWALzBilWjbH_o4g",
    cloud_name: "my-personal-projects"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
