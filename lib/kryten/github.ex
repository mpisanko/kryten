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
    end)
    |> List.flatten
    |> Enum.group_by(fn p -> Map.get(p, "base") |> Map.get("repo") |> Map.get("name") end)
    |> Enum.reduce(%{}, fn {project, prs}, acc -> Map.put(acc, project, Enum.map(prs, fn pr -> "#{Map.get(pr, "title")}: #{Map.get(pr, "url")}" end)) end)
    |> Enum.map(fn {project, prs} -> "\n*#{project}*\n#{Enum.map(prs, fn pr -> "• #{pr}\n" end)}" end)  |> Enum.join("")
  end

  def get_prs(name), do: "pulls #{name}"

  ## CALLBACKS

  def process_url("repos"), do: "https://api.github.com/orgs/#{@org}/repos?type=private"
  def process_url("pulls " <> repo), do: "https://api.github.com/repos/#{@org}/#{repo}/pulls?state=open"

  def auth, do: [hackney: [insecure: true, basic_auth: {github_user, github_token}]]

  def github_user, do: Application.get_env(:kryten, :github_user)

  def github_token, do: Application.get_env(:kryten, :github_token)

end
