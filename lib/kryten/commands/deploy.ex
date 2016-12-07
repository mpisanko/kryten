defmodule Kryten.Command.Deploy do
  alias Kryten.Jenkins
  import Slack.Sends

  def can_handle?(_message = %{text: message_text}, slack) do
    matches(message_text, slack.me.id)
    |> legit_project?
    |> case do
         nil -> false
         _ -> true
    end
  end
  def can_handle?(_, _), do: false

  def handle(message, slack) do
    project = Map.get(matches(message.text, slack.me.id), "project")
    send_message("<@#{message.user}> deploying #{project}", message.channel, slack)
    Jenkins.deploy project
  end

  defp matches(text, id), do: Regex.named_captures ~r/<@#{id}>:?\sdeploy\s+(?<project>\w+)/, text
  defp legit_project?(nil), do: nil
  defp legit_project?(p_regex), do: if Regex.match?(~r/\w+_staging(_deploy)?/, Map.get(p_regex, "project")), do: p_regex, else: nil

end
