defmodule Kryten.Authorisation.Service do
  use GenServer

  @domain Application.get_env(:kryten, :authorised_domain)

  def start_link(slack_token), do: GenServer.start_link __MODULE__, {:ok, slack_token}, name: __MODULE__

  def init({:ok, slack_token}) do
    ids = Application.get_env(:kryten, :authorised_users)
    |> Enum.map(fn u -> "#{u}@#{@domain}" end)
    |> lookup_ids(slack_token)

    {:ok, ids}
  end

  def authorised?(slack_id), do: GenServer.call(__MODULE__, {:authorised?, slack_id})

  def handle_call({:authorised?, slack_id}, _from, authorised_users), do: {:reply, Enum.member?(authorised_users, slack_id), authorised_users}

  defp lookup_ids(email_addresses, slack_token) do
    Slack.Web.Users.list(%{token: slack_token})
    |> Map.get("members")
    |> Enum.filter(fn u -> Enum.member?(email_addresses, get_in(u, ["profile", "email"])) end)
    |> Enum.map(fn(member) -> member["id"] end)
  end
end
