defmodule Kryten.Bot do
  use Slack
  alias Kryten.{Command}

  def start_link(token) do
    Slack.Bot.start_link(__MODULE__, [], token)
  end

  def handle_connect(_slack, state) do
    {:ok, state}
  end

  def handle_event(message = %{type: "message", text: message_text}, slack, state) do
    _handle_message(message, slack, Command.all)
    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

  defp _handle_message(_, _, []), do: nil
  defp _handle_message(message, slack, [command|commands]), do: _try_handle_message(command.can_handle?(message, slack), message, slack, command, commands)

  defp _try_handle_message(true, message, slack, command, _), do: command.handle(message, slack)
  defp _try_handle_message(false, message, slack, _, commands), do: _handle_message(message, slack, commands)

end
