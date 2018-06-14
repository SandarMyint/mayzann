# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Uberauth Configuration
config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [send_redirect_uri: false]}
  ]


# OAuth Config
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "97884981a3c6ed8012bf",
  client_secret: "b6b6aa6911b9303aa1a7ef0eb990151792f0f53f"

# General application configuration
config :mayzann,
  ecto_repos: [Mayzann.Repo]

# Configures the endpoint
config :mayzann, MayzannWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mdEsmyAA4q6E150fDCWRaNvTgkwsYVmIvNIXZgOKFy4IxyPSob2N0bePNPIUHa/9",
  render_errors: [view: MayzannWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mayzann.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
