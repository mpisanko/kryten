defmodule Kryten.Bot do
  use Slack
  alias Kryten.{Command}
  alias Kryten.Authorisation.Service, as: Auth

  @kryten Application.get_env :kryten, :kryten_user_id

  def start_link(token) do
    Slack.Bot.start_link(__MODULE__, [], token)
  end

  def handle_connect(_slack, state) do
    {:ok, state}
  end

  def handle_event(message = %{type: "message", user: @kryten}, _slack, state), do: {:ok, state}
  def handle_event(message = %{type: "message", text: message_text}, slack, state) do
    message
    |> IO.inspect
    |> ensure_authorised(slack)
    |> IO.inspect
    |> _handle_message(slack, Command.all)

    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

  defp _handle_message(:error, _, _), do: nil
  defp _handle_message(_, _, []), do: nil
  defp _handle_message(message, slack, [command|commands]), do: _try_handle_message(command.can_handle?(message, slack), message, slack, command, commands)

  defp _try_handle_message(true, message, slack, command, _), do: command.handle(message, slack)
  defp _try_handle_message(false, message, slack, _, commands), do: _handle_message(message, slack, commands)

  defp ensure_authorised(message = %{user: user}, slack) do
    case Auth.authorised?(user) do
      true -> message
      false ->
        send_message("<@#{message.user}> You are not authorised.", message.channel, slack)
        :error
    end
  end

end
