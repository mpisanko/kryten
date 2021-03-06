use Mix.Config

config :kryten,
  slack_token: System.get_env("SLACK_TOKEN"),
  jenkins_token: System.get_env("JENKINS_TOKEN"),
  github_user: System.get_env("GITHUB_USER"),
  github_token: System.get_env("GITHUB_TOKEN"),
  circle_token: System.get_env("CCI_TOKEN"),
  authorised_domain: "jobseeker.com.au",
  authorised_users: [
    "michal.pisanko",
    "ben.hallett",
    "cuong.hoang",
    "douglas.roeder",
    "felipe.nakandakari",
    "jason.mcglade",
    "kirill.lastovirya",
    "andrei.miulescu",
    "sanghyun.park",
    "son.phung",
    "ren.shao",
    "max.flander",
    "mark.pritchard",
    "tim.wen",
    "wayne.see",
    "pierre.caserta"
  ],
  kryten_user_id: "U3BCSMC9Z"

config :junit_formatter,
  report_file: "results.xml",
  print_report_file: true

#     import_config "#{Mix.env}.exs"
