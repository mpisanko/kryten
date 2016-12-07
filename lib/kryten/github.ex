defmodule Kryten.Github do
  use HTTPoison.Base

  @org "jobseekerltd"

  ## API

  def open_pull_requests do
    get!("repos", %{}, auth)
    |> Map.get(:body)
    |> Poison.decode!
    |> Enum.map(fn repo ->
      Map.get(repo, "name")
      |> get_prs
      |> get!(%{}, auth)
      |> Map.get(:body)
      |> Poison.decode!
      |> Enum.map(fn pr -> {Map.get(pr, "title"), Map.get(pr, "url")} end)
    end)
    # get!("repos")
    # map
    #   get!("pulls #{repo}")
    # map those to links
  end

  def get_prs(name), do: "pulls #{name}"

  ## CALLBACKS

  def process_url("repos"), do: "https://api.github.com/orgs/#{@org}/repos?type=private"
  def process_url("pulls " <> repo), do: "https://api.github.com/repos/#{@org}/#{repo}/pulls?state=open"

  def auth, do: [hackney: [insecure: true, basic_auth: {github_user, github_token}]]

  def github_user, do: Application.get_env(:kryten, :github_user)

  def github_token, do: Application.get_env(:kryten, :github_token)

end
