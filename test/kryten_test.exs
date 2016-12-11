defmodule KrytenTest do
  use ExUnit.Case, async: true

  test "restart strategy is one_for_one" do
    strategy = Kryten.options |> Keyword.get(:strategy)
    assert strategy == :one_for_one
  end

end
