defmodule Kryten do
  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args), do: Supervisor.start_link(children, options)

  def options, do: [strategy: :one_for_one, name: Kryten.Supervisor]

  defp children, do: [worker(Kryten.Bot, [slack_token])]

  defp slack_token, do: Application.get_env(:kryten, :slack_token)
end
