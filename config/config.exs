use Mix.Config

config :kryten,
  slack_token: System.get_env("SLACK_TOKEN"),
  jenkins_token: System.get_env("JENKINS_TOKEN"),
  github_user: System.get_env("GITHUB_USER"),
  github_token: System.get_env("GITHUB_TOKEN")

#     import_config "#{Mix.env}.exs"
