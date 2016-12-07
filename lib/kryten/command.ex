defmodule Kryten.Command do

  def all do
    [
      Kryten.Command.Deploy,
      Kryten.Command.PullRequest,
      Kryten.Command.Unknown
    ]
  end

end
