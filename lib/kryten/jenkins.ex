defmodule Kryten.Jenkins do
  use HTTPoison.Base

  ## API

  def deploy(project) do
    post!(project, "", %{"Content-Type" => "application/x-www-form-urlencoded"}, auth)
  end

  ## CALLBACKS

  def process_url(project) do
    "https://cicd.jora.com/job/#{project}/build"
  end

  def auth, do: [hackney: [insecure: true, basic_auth: {github_user, github_token}]]

  def github_user, do: Application.get_env(:kryten, :github_user)

  def github_token, do: Application.get_env(:kryten, :github_token)

end
