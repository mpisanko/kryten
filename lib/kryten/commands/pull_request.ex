defmodule Kryten.Command.PullRequest do
  alias Kryten.Github
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
    prs = Github.open_pull_requests
    send_message("<@#{message.user}> Open Pull Requests\n\n#{prs}", message.channel, slack)
  end

  defp matches(text, id), do: Regex.named_captures ~r/<@#{id}>:?\s+(pull requests|PRs)/i, text

end
