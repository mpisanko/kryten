use Mix.Config

config :kryten,
  token: System.get_env("SLACK_TOKEN")

#     import_config "#{Mix.env}.exs"
