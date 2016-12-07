defmodule Kryten.Bot do
  use Slack
  alias Kryten.{Jenkins, Github}

  def start_link(token) do
    Slack.Bot.start_link(__MODULE__, [], token)
  end

  def handle_connect(_slack, state) do
    {:ok, state}
  end

  def handle_event(message = %{type: "message", text: message_text}, slack, state) do
    matches = Regex.named_captures ~r/<@#{slack.me.id}>:?\sdeploy\s(?<project>\w+)/, message_text

    if matches do
      project = Map.get(matches, "project")
      send_message("<@#{message.user}> deploying #{project}", message.channel, slack)
      Jenkins.deploy project
    end

    pr_matches = Regex.named_captures ~r/<@#{slack.me.id}>:?\spull requests/, message_text

    if pr_matches do
      prs = Github.open_pull_requests
      send_message("<@#{message.user}> Open Pull Requests\n\n#{prs}", message.channel, slack)
    end

    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

end
