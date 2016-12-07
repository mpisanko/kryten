defmodule Kryten.Command.Unknown do
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
    send_message("<@#{message.user}> I do not understand that. Right now I support `deploy $PROJECT` and `pull requests/PRs`. Also I will only deploy a project to `staging`.", message.channel, slack)
  end

  defp matches(text, id), do: Regex.named_captures ~r/<@#{id}>:?/, text

end
