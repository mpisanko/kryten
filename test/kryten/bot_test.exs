defmodule Kryten.BotTest do
  use ExUnit.Case, async: true
  alias Kryten.Bot

  test "handle_connect doesnt modify state" do
    state = %{a: "A", b: "B"}
    {:ok, s} = Bot.handle_connect(nil, state)
    assert state == s
  end

end
