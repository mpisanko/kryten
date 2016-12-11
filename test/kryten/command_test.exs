defmodule Kryten.CommandTest do
  use ExUnit.Case, async: true
  alias Kryten.Command

  test "has expected command pipeline" do
    assert Command.all == [
      Kryten.Command.Deploy,
      Kryten.Command.PullRequest,
      Kryten.Command.Unknown
    ]
  end

end
