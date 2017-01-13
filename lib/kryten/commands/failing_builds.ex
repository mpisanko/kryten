defmodule Kryten.Command.FailingBuilds do
  alias Kryten.Circle
  import Slack.Sends

  def can_handle?(_message = %{text: message_text}, slack) do
    matches(message_text, slack.me.id)
    |> case do
         nil -> false
         _ -> true
    end
  end
  def can_handle?(_, _), do: false

  def handle(message, slack) do
    builds = Circle.failing_builds
    send_message("<@#{message.user}> failing builds are:\n#{builds}", message.channel, slack)
  end

  defp matches(text, id), do: Regex.named_captures ~r/<@#{id}>:?\s(failing builds|fb)/i, text

end
