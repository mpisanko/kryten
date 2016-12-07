defmodule Kryten.Bot do
  use Slack

  def start_link(token) do
    Slack.Bot.start_link(__MODULE__, [], token)
  end

  def handle_connect(slack, state) do
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    IO.inspect message
    matches = Regex.named_captures ~r/<@#{slack.me.id}>:?\sdeploy\s(?<project>\w+)/, message.text

    if matches do
      send_message("<@#{message.user}> deploying #{Map.get(matches, "project")}", message.channel, slack)

    end

    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

end
